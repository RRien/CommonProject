using Avalonia.Controls;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorAppointmentCard : Window
{
    private int _appointmentId;

    public DoctorAppointmentCard(int appointmentId)
    {
        InitializeComponent();
        _appointmentId = appointmentId;
        LoadData();
    }

    private void LoadData()
    {
        var db = new AppDbContext();

        var app = db.Appointments
            .Include(a => a.IdPatientNavigation)
            .Include(a => a.IdServiceNavigation)
            .Include(a => a.IdStatusNavigation)
            .FirstOrDefault(a => a.IdAppointment == _appointmentId);

        if (app != null)
        {
            txtPatient.Text = $"{app.IdPatientNavigation.LastNamePatient} {app.IdPatientNavigation.FirstNamePatient}";
            txtService.Text = app.IdServiceNavigation.NameService;
            txtDateTime.Text = $"{app.DateAppointment:dd.MM.yyyy} {app.TimeAppointment:hh\\:mm}";

            txtComplaints.Text = app.ComplaintsAppointment;
            txtDiagnosis.Text = app.DiagnosisAppointment;
            txtRecommendations.Text = app.RecommendationsAppointment;

            foreach (var item in cmbStatus.Items)
            {
                if (item is ComboBoxItem ci && ci.Content?.ToString() == app.IdStatusNavigation.NameStatus)
                {
                    cmbStatus.SelectedItem = ci;
                    break;
                }
            }
        }
    }

    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {
        var db = new AppDbContext();
        var app = db.Appointments.Find(_appointmentId);

        if (app == null) return;
        app.ComplaintsAppointment = txtComplaints.Text;
        app.DiagnosisAppointment = txtDiagnosis.Text;
        app.RecommendationsAppointment = txtRecommendations.Text;

        var statusText = ((ComboBoxItem?)cmbStatus.SelectedItem)?.Content?.ToString()?.Trim();
        var status = db.AppointmentStatuses.FirstOrDefault(s => s.NameStatus == statusText);

        if (status != null)
        {
            app.IdStatus = status.IdStatus;
        }

        await db.SaveChangesAsync();
        this.Close();
    }

    private void BtnCancel_Click(object? sender, RoutedEventArgs e)
    {
        this.Close();
    }
}