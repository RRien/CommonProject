using Avalonia.Controls;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorReferralsCard : Window
{
    private int _referralId;
    private int _doctorId;
    private bool _isNew;

    public DoctorReferralsCard(int referralId, int doctorId)
    {
        InitializeComponent();
        _referralId = referralId;
        _doctorId = doctorId;
        _isNew = referralId == 0;

        LoadDictionaries();
        if (!_isNew) LoadData();
    }

    private void LoadDictionaries()
    {
        var db = new AppDbContext();

        var appointments = db.Appointments
            .Include(a => a.IdPatientNavigation)
            .Include(a => a.IdServiceNavigation)
            .Where(a => a.IdDoctor == _doctorId)
            .OrderBy(a => a.DateAppointment)
            .ThenBy(a => a.TimeAppointment)
            .ToList();

        cmbAppointment.ItemsSource = appointments;
        cmbResearch.ItemsSource = db.LabResearches.OrderBy(r => r.NameLabResearch).ToList();
    }

    private void LoadData()
    {
        using var db = new AppDbContext();

        var referral = db.ResearchReferrals
            .Include(r => r.IdAppointmentNavigation)
            .Include(r => r.IdLabResearchNavigation)
            .FirstOrDefault(r => r.IdReferral == _referralId);

        if (referral != null)
        {
            cmbAppointment.SelectedItem = cmbAppointment.Items
                .FirstOrDefault(a => ((Appointment)a).IdAppointment == referral.IdAppointment);

            cmbResearch.SelectedItem = cmbResearch.Items
                .FirstOrDefault(r => ((LabResearch)r).IdLabResearch == referral.IdLabResearch);
        }
    }

    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {

        var db = new AppDbContext();

        var appointment = (Appointment)cmbAppointment.SelectedItem;
        var research = (LabResearch)cmbResearch.SelectedItem;

        if (_isNew)
        {
            var referral = new ResearchReferral
            {
                IdAppointment = appointment.IdAppointment,
                IdLabResearch = research.IdLabResearch,
                ReferralDateReferral = DateTime.Now
            };
            db.ResearchReferrals.Add(referral);
        }
        else
        {
            var referral = db.ResearchReferrals.Find(_referralId);
            if (referral != null)
            {
                referral.IdAppointment = appointment.IdAppointment;
                referral.IdLabResearch = research.IdLabResearch;
                db.ResearchReferrals.Update(referral);
            }
        }

        await db.SaveChangesAsync();
        this.Close();
    }

    private void BtnCancel_Click(object? sender, RoutedEventArgs e)
    {
        this.Close();
    }
}