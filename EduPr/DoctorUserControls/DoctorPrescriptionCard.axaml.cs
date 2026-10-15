using Avalonia.Controls;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorPrescriptionCard : Window
{
    private int _prescriptionId;
    private int _doctorId;
    private bool _isNew;

    public DoctorPrescriptionCard(int prescriptionId, int doctorId)
    {
        InitializeComponent();
        _prescriptionId = prescriptionId;
        _doctorId = doctorId;
        _isNew = prescriptionId == 0;

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
        cmbMedication.ItemsSource = db.Medications.OrderBy(m => m.NameMedication).ToList();
    }

    private void LoadData()
    {
        var db = new AppDbContext();

        var prescription = db.MedicationPrescriptions
            .Include(p => p.IdAppointmentNavigation)
            .Include(p => p.IdMedicationNavigation)
            .FirstOrDefault(p => p.IdPrescription == _prescriptionId);

        if (prescription != null)
        {
            cmbAppointment.SelectedItem = cmbAppointment.Items
                .FirstOrDefault(a => ((Appointment)a).IdAppointment == prescription.IdAppointment);

            cmbMedication.SelectedItem = cmbMedication.Items
                .FirstOrDefault(m => ((Medication)m).IdMedication == prescription.IdMedication);

            txtDosage.Text = prescription.DosagePrescription;
            numDuration.Value = prescription.DurationDaysPrescription;
            txtInstructions.Text = prescription.InstructionsPrescription;
        }
    }

    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {
        if (cmbAppointment.SelectedItem == null || cmbMedication.SelectedItem == null)
        {
            var err = new Window
            {
                Content = new TextBlock { Text = "Выберите приём и препарат!", Foreground = Avalonia.Media.Brushes.Red },
                Width = 350,
                Height = 150
            };
            await err.ShowDialog(this);
            return;
        }

        var db = new AppDbContext();
        var appointment = (Appointment)cmbAppointment.SelectedItem;
        var medication = (Medication)cmbMedication.SelectedItem;

        if (_isNew)
        {
            var prescription = new MedicationPrescription
            {
                IdAppointment = appointment.IdAppointment,
                IdMedication = medication.IdMedication,
                DosagePrescription = txtDosage.Text,
                DurationDaysPrescription = (int)(numDuration.Value ?? 7),
                InstructionsPrescription = txtInstructions.Text
            };
            db.MedicationPrescriptions.Add(prescription);
        }
        else
        {
            var prescription = db.MedicationPrescriptions.Find(_prescriptionId);
            if (prescription != null)
            {
                prescription.IdAppointment = appointment.IdAppointment;
                prescription.IdMedication = medication.IdMedication;
                prescription.DosagePrescription = txtDosage.Text;
                prescription.DurationDaysPrescription = (int)(numDuration.Value ?? 7);
                prescription.InstructionsPrescription = txtInstructions.Text;
                db.MedicationPrescriptions.Update(prescription);
            }
        }

        await db.SaveChangesAsync();
        this.Close();
    }

    private void BtnCancel_Click(object? sender, RoutedEventArgs e) => this.Close();
}