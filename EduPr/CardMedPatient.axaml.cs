using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;

namespace EduPr;

public partial class CardMedPatient : Window
{
    private int _patientId;
    private bool _isNewPatient;

    public CardMedPatient(int PatientId)
    {
        InitializeComponent();
        _patientId = PatientId;
        _isNewPatient = _patientId == 0;

        if (!_isNewPatient)
        {
            Title = "Медицинская карта пациента";
        }
        else
        {
            Title = "Создание нового пациента";
        }
        MainContentControl.Content = new PatientPersonal(_patientId, _isNewPatient);
    }

    private void LogButton_Click(object? sender, RoutedEventArgs e)
    {
        this.Close();
    }

    private void BtnPersonal_Click(object? sender, RoutedEventArgs e)
    {
        MainContentControl.Content = new PatientPersonal(_patientId, _isNewPatient);
    }

    private void BtnAppointments_Click(object? sender, RoutedEventArgs e)
    {
        if (!_isNewPatient)
        {
            MainContentControl.Content = new PatientAppointments(_patientId);
        }
    }

    private void BtnPrescriptions_Click(object? sender, RoutedEventArgs e)
    {
        if (!_isNewPatient)
        {
            MainContentControl.Content = new PatientPrescriptions(_patientId);
        }
    }

    private void BtnExaminations_Click(object? sender, RoutedEventArgs e)
    {
        if (!_isNewPatient)
        {
            MainContentControl.Content = new PatientExaminations(_patientId);
        }
    }
}