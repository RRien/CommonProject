using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace EduPr;

public partial class AppointmentCard : Window
{
    private int _appointmentId;
    private bool _isNew;

    public AppointmentCard(int appointmentId = 0)
    {
        InitializeComponent();
        _appointmentId = appointmentId;
        _isNew = appointmentId == 0;

        LoadDictionaries();
        if (!_isNew) LoadData();
    }

    private void LoadDictionaries()
    {
        var db = new AppDbContext();
        cmbPatient.ItemsSource = db.Patients.OrderBy(p => p.LastNamePatient).ToList();
        cmbDoctor.ItemsSource = db.Doctors.OrderBy(d => d.LastNameDoctor).ToList();
        cmbService.ItemsSource = db.Services.ToList();
        cmbCabinet.ItemsSource = db.Cabinets.OrderBy(c => c.NumberCabinet).ToList();
    }

    private void LoadData()
    {
        var db = new AppDbContext();
        var app = db.Appointments
            .Include(a => a.IdStatusNavigation)
            .FirstOrDefault(a => a.IdAppointment == _appointmentId);

        if (app == null) return;

        cmbPatient.SelectedItem = cmbPatient.Items.FirstOrDefault(p => ((Patient)p).IdPatient == app.IdPatient);
        cmbDoctor.SelectedItem = cmbDoctor.Items.FirstOrDefault(d => ((Doctor)d).IdDoctor == app.IdDoctor);
        cmbService.SelectedItem = cmbService.Items.FirstOrDefault(s => ((Service)s).IdService == app.IdService);
        cmbCabinet.SelectedItem = cmbCabinet.Items.FirstOrDefault(c => ((Cabinet)c).IdCabinet == app.IdCabinet);

        dpDate.SelectedDate = app.DateAppointment.ToDateTime(TimeOnly.MinValue);
        tpTime.SelectedTime = app.TimeAppointment.ToTimeSpan();

        string targetStatus = app.IdStatusNavigation?.NameStatus?.Trim() ?? "";

        foreach (ComboBoxItem item in cmbStatus.Items)
        {
            if (item.Content?.ToString()?.Trim() == targetStatus)
            {
                cmbStatus.SelectedItem = item;
                break;
            }
        }
    }

    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {
        if (cmbPatient.SelectedItem == null || cmbDoctor.SelectedItem == null ||
            cmbService.SelectedItem == null || cmbCabinet.SelectedItem == null ||
            !dpDate.SelectedDate.HasValue || !tpTime.SelectedTime.HasValue)
        {
            await ShowError("Заполните все обязательные поля!");
            return;
        }

        var db = new AppDbContext();

        var patient = (Patient)cmbPatient.SelectedItem;
        var doctor = (Doctor)cmbDoctor.SelectedItem;
        var service = (Service)cmbService.SelectedItem;
        var cabinet = (Cabinet)cmbCabinet.SelectedItem;

        var statusText = ((ComboBoxItem?)cmbStatus.SelectedItem)?.Content?.ToString()?.Trim();
        var status = db.AppointmentStatuses.FirstOrDefault(s => s.NameStatus == statusText);

        var date = DateOnly.FromDateTime(dpDate.SelectedDate.Value.DateTime);
        var time = TimeOnly.FromTimeSpan(tpTime.SelectedTime.Value);

        if (_isNew)
        {
            var newApp = new Appointment
            {
                IdPatient = patient.IdPatient,
                IdDoctor = doctor.IdDoctor,
                IdService = service.IdService,
                IdCabinet = cabinet.IdCabinet,
                DateAppointment = date,
                TimeAppointment = time,
                CreatedAppointment = DateTime.Now
            };

            if (status != null) newApp.IdStatus = status.IdStatus;

            db.Appointments.Add(newApp);
        }
        else
        {
            var existingApp = db.Appointments.Find(_appointmentId);

            if (existingApp != null)
            {
                existingApp.IdPatient = patient.IdPatient;
                existingApp.IdDoctor = doctor.IdDoctor;
                existingApp.IdService = service.IdService;
                existingApp.IdCabinet = cabinet.IdCabinet;
                existingApp.DateAppointment = date;
                existingApp.TimeAppointment = time;

                if (status != null) existingApp.IdStatus = status.IdStatus;

                db.Appointments.Update(existingApp);
            }
        }

        await db.SaveChangesAsync();
        this.Close();
    }

    private async Task ShowError(string message)
    {
        var win = new Window
        {
            Content = new TextBlock { Text = message, Foreground = Avalonia.Media.Brushes.Red },
            Width = 350,
            Height = 150,
            WindowStartupLocation = WindowStartupLocation.CenterOwner
        };
        await win.ShowDialog(this);
    }

    private void BtnCancel_Click(object? sender, RoutedEventArgs e)
    {
        this.Close();
    }
}