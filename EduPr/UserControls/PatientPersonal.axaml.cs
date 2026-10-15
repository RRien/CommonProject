using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using System;

namespace EduPr;

public partial class PatientPersonal : UserControl
{
    private int _patientId;
    private bool _isNewPatient;

    public PatientPersonal(int patientId, bool isNewPatient)
    {
        InitializeComponent();
        _patientId = patientId;
        _isNewPatient = isNewPatient;

        if (!_isNewPatient)
        {
            LoadData();
        }
    }

    private void LoadData()
    {
        var context = new AppDbContext();
        var patient = context.Patients.Find(_patientId);

        if (patient != null)
        {
            LastNameTb.Text = patient.LastNamePatient;
            FirstNameTb.Text = patient.FirstNamePatient;
            MiddleNameTb.Text = patient.MiddleNamePatient;
            PhoneTb.Text = patient.PhonePatient;

            if (patient.BirthDatePatient.HasValue)
            {
                dpBirthDate.SelectedDate = patient.BirthDatePatient.Value.ToDateTime(TimeOnly.MinValue);
            }
        }
    }



    private async void BtnSave_Click(object? sender, RoutedEventArgs e)
    {

        var context = new AppDbContext();
        Patient patient;

        DateOnly? birthDate = null;
        if (dpBirthDate.SelectedDate.HasValue)
        {
            birthDate = DateOnly.FromDateTime(dpBirthDate.SelectedDate.Value.DateTime);
        }

        if (_isNewPatient)
        {
            patient = new Patient
            {
                LastNamePatient = LastNameTb.Text,
                FirstNamePatient = FirstNameTb.Text,
                MiddleNamePatient = MiddleNameTb.Text,
                PhonePatient = PhoneTb.Text,
                BirthDatePatient = birthDate,
                CreatedPatient = DateTime.Now
            };
            context.Patients.Add(patient);
        }
        else
        {
            patient = context.Patients.Find(_patientId);
            if (patient != null)
            {
                patient.LastNamePatient = LastNameTb.Text ?? "";
                patient.FirstNamePatient = FirstNameTb.Text ?? "";
                patient.MiddleNamePatient = MiddleNameTb.Text;
                patient.PhonePatient = PhoneTb.Text;
                patient.BirthDatePatient = birthDate;
                context.Patients.Update(patient);
            }
        }

        await context.SaveChangesAsync();

        var parentWindow = this.VisualRoot as Window;
        parentWindow?.Close();
    }
}