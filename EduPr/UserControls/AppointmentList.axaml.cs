using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class AppointmentList : UserControl
{
    public AppointmentList()
    {
        InitializeComponent();
        LoadAppointments("", "Все статусы");
    }

    private void LoadAppointments(string searchText, string statusFilter)
    {
        var context = new AppDbContext();

        var appointments = context.Appointments
            .Include(a => a.IdPatientNavigation)
            .Include(a => a.IdDoctorNavigation)
            .Include(a => a.IdServiceNavigation)
            .Include(a => a.IdStatusNavigation)
            .ToList();
        if (!string.IsNullOrWhiteSpace(searchText))
        {
            appointments = appointments.Where(a =>
                (a.IdPatientNavigation?.LastNamePatient.Contains(searchText) ?? false) ||
                (a.IdPatientNavigation?.FirstNamePatient.Contains(searchText) ?? false) ||
                (a.IdDoctorNavigation?.LastNameDoctor.Contains(searchText) ?? false) ||
                (a.IdDoctorNavigation?.FirstNameDoctor.Contains(searchText) ?? false)
            ).ToList();
        }
        if (!string.IsNullOrWhiteSpace(statusFilter) && statusFilter != "Все статусы")
        {
            appointments = appointments.Where(a =>
                a.IdStatusNavigation?.NameStatus == statusFilter
            ).ToList();
        }

        AppointmentsGrid.ItemsSource = appointments
            .OrderBy(a => a.DateAppointment)
            .ThenBy(a => a.TimeAppointment)
            .ToList();
    }

    private string GetSelectedStatus()
    {
        return (statusFilter.SelectedItem as ComboBoxItem)?.Content?.ToString() ?? "Все статусы";
    }

    private void Search_TextChanged(object? sender, TextChangedEventArgs e)
    {
        LoadAppointments(searchTb.Text, GetSelectedStatus());
    }

    private void StatusFilter_Changed(object? sender, SelectionChangedEventArgs e)
    {
        LoadAppointments(searchTb.Text, GetSelectedStatus());
    }

    private void Search_Click(object? sender, RoutedEventArgs e)
    {
        LoadAppointments(searchTb.Text, GetSelectedStatus());
    }

    private async void Appointment_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selected = AppointmentsGrid.SelectedItem as Appointment;
        if (selected == null) return;

        var card = new AppointmentCard(selected.IdAppointment);
        await card.ShowDialog(this.VisualRoot as Window);

        LoadAppointments(searchTb.Text, GetSelectedStatus());
    }

    private async void AddAppointment_Click(object? sender, RoutedEventArgs e)
    {
        var card = new AppointmentCard(0);
        await card.ShowDialog(this.VisualRoot as Window);

        LoadAppointments(searchTb.Text, GetSelectedStatus());
    }
}