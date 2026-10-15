using Avalonia.Controls;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class HeadAdvancedAnalytics : UserControl
{
    public HeadAdvancedAnalytics()
    {
        InitializeComponent();
        LoadFilters();
        CalculateMetrics();
    }

    public void LoadFilters()
    {
        using var db = new AppDbContext();

        CbFilterDoctor.ItemsSource = db.Doctors.Include(d => d.IdSpecializationNavigation).OrderBy(d => d.LastNameDoctor).ToList();

        CbFilterSpecialization.ItemsSource = db.Specializations.OrderBy(s => s.NameSpecialization).ToList();

        CbFilterDepartment.ItemsSource = db.Departments.OrderBy(d => d.NameDepartment).ToList();
    }
    private void Filter_SelectionChanged(object? sender, SelectionChangedEventArgs e)
    {
        CalculateMetrics();
    }

    private void Filter_DateChanged(object? sender, DatePickerSelectedValueChangedEventArgs e)
    {
        CalculateMetrics();
    }

    private void CalculateMetrics()
    {
        var db = new AppDbContext();
        var allAppointments = db.Appointments.Include(a => a.IdPatientNavigation).Include(a => a.IdDoctorNavigation).ThenInclude(d => d.IdSpecializationNavigation).Include(a => a.IdDoctorNavigation).ThenInclude(d => d.IdDepartmentNavigation).Include(a => a.IdServiceNavigation).Include(a => a.IdStatusNavigation).Include(a => a.IdCabinetNavigation).ThenInclude(c => c.IdDepartmentNavigation).ToList();

        var appointments = allAppointments;

        if (CbFilterDoctor.SelectedItem is Doctor selectedDoctor)
        {
            appointments = appointments.Where(a => a.IdDoctor == selectedDoctor.IdDoctor).ToList();
        }

        if (CbFilterSpecialization.SelectedItem is Specialization selectedSpec)
        {
            appointments = appointments.Where(a => a.IdDoctorNavigation.IdSpecialization == selectedSpec.IdSpecialization).ToList();
        }

        if (CbFilterDepartment.SelectedItem is Department selectedDept)
        {
            appointments = appointments.Where(a => a.IdDoctorNavigation.IdDepartment == selectedDept.IdDepartment).ToList();
        }

        if (dpFilterDate.SelectedDate.HasValue)
        {
            var selectedDate = DateOnly.FromDateTime(dpFilterDate.SelectedDate.Value.DateTime);
            appointments = appointments.Where(a => a.DateAppointment == selectedDate).ToList();
        }

        var filteredList = appointments.ToList();

        decimal totalRevenue = filteredList.Where(a => a.IdStatusNavigation?.NameStatus == "Завершена").Sum(a => a.IdServiceNavigation?.CostService ?? 0);
        txtRevenuePeriod.Text = $"{totalRevenue:0.00} ₽";

        var previousPeriodRevenue = db.Appointments.Include(a => a.IdServiceNavigation).Include(a => a.IdStatusNavigation).Where(a => a.IdStatusNavigation.NameStatus == "Завершена").Sum(a => a.IdServiceNavigation.CostService);

        if (previousPeriodRevenue > 0)
        {
            var change = ((totalRevenue - previousPeriodRevenue) / previousPeriodRevenue) * 100;
            txtRevenueCompare.Text = change >= 0 ? $"↑ +{change:F1}% к общему объёму" : $"↓ {change:F1}% к общему объёму";
        }

        if (filteredList.Count > 0)
        {
            var avgDuration = filteredList.Average(a => a.IdServiceNavigation?.DurationMinutesService ?? 0);
            txtAvgDuration.Text = $"{avgDuration:0} мин";
        }
        else
        {
            txtAvgDuration.Text = "0 мин";
        }
        var totalPatients = filteredList.Select(a => a.IdPatient).Distinct().Count();
        var repeatPatients = filteredList.GroupBy(a => a.IdPatient).Where(g => g.Count() > 1).Count();

        if (totalPatients > 0)
        {
            var repeatRate = (repeatPatients * 100.0) / totalPatients;
            txtRepeatRate.Text = $"{repeatRate:F1}%";
        }
        else
        {
            txtRepeatRate.Text = "0%";
        }

        var topService = filteredList.GroupBy(a => a.IdServiceNavigation).OrderByDescending(g => g.Count()).FirstOrDefault();

        if (topService != null)
        {
            txtTopService.Text = topService.Key?.NameService ?? "-";
            txtTopServiceCount.Text = $"{topService.Count()} приёмов";
        }
        else
        {
            txtTopService.Text = "-";
            txtTopServiceCount.Text = "0 приёмов";
        }
        txtTotalAppointments.Text = filteredList.Count.ToString();

        var topServices = filteredList.GroupBy(a => new { a.IdService, a.IdServiceNavigation.NameService }).Select(g => new TopServiceItem
        {
            Name = g.Key.NameService,
            Count = g.Count(),
            Percentage = filteredList.Count > 0 ? (g.Count() * 100.0) / filteredList.Count : 0
        })
            .OrderByDescending(x => x.Count).Take(5).ToList();

        GridTopServices.ItemsSource = topServices;
    }

    public class TopServiceItem
    {
        public string Name { get; set; } = "";
        public int Count { get; set; }
        public double Percentage { get; set; }
    }
}