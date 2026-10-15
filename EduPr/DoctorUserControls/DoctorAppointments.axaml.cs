using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorAppointments : UserControl
{
    private int _doctorId;
    private List<Appointment> _allAppointments = new(); 

    public DoctorAppointments(int doctorId)
    {
        InitializeComponent();
        _doctorId = doctorId;


        Pagination.PageChanged += (s, page) => LoadPage(page); //Когда пользователь кликает кнопку вперед внутри контроля для пагинации, он же увеличивает счетчик CurrentPage и  вызывыет событие передавая новый номер страницы, а этот класс ловит данное событие и показывает новую страницу

        LoadAppointments(null);
    }

    private void LoadAppointments(DateTime? filterDate)
    {
        var db = new AppDbContext();

        var query = db.Appointments
            .Include(a => a.IdPatientNavigation)
            .Include(a => a.IdServiceNavigation)
            .Include(a => a.IdCabinetNavigation)
            .Include(a => a.IdStatusNavigation)
            .Where(a => a.IdDoctor == _doctorId);

        if (filterDate.HasValue)
        {
            var dateOnly = DateOnly.FromDateTime(filterDate.Value);
            query = query.Where(a => a.DateAppointment == dateOnly);
        }
        _allAppointments = query
            .OrderBy(a => a.DateAppointment)
            .ThenBy(a => a.TimeAppointment)
            .ToList();

        Pagination.SetTotalItems(_allAppointments.Count);

        LoadPage(1);
    }

    private void LoadPage(int page)
    {
        var skip = (page - 1) * Pagination.PageSize; // например если нажата первая страница , по расчету мы пропускаем 0 элементов и  счетчик выводит первые 5 элементов
        var pageData = _allAppointments.Skip(skip).Take(Pagination.PageSize).ToList(); 

        AppointmentsGrid.ItemsSource = pageData;
    }

    private void DateFilter_Changed(object? sender, DatePickerSelectedValueChangedEventArgs e)
    {
        LoadAppointments(dpFilterDate.SelectedDate?.DateTime);
    }

    private void ShowAll_Click(object? sender, RoutedEventArgs e)
    {
        dpFilterDate.SelectedDate = null;
        LoadAppointments(null);
    }

    private async void Appointment_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selected = AppointmentsGrid.SelectedItem as Appointment;
        if (selected == null) return;

        var card = new DoctorAppointmentCard(selected.IdAppointment);
        await card.ShowDialog(this.VisualRoot as Window);

        LoadAppointments(dpFilterDate.SelectedDate?.DateTime);
    }
}