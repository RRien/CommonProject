using Avalonia.Controls;
using Avalonia.Interactivity;
using EduPr.Data;

namespace EduPr;

public partial class DoctorWindow : Window
{
    private int _doctorId;
    private Doctor _currentDoctor;
    public DoctorWindow(Doctor doctor)
    {
        InitializeComponent();
        _currentDoctor = doctor;
        _doctorId = doctor.IdDoctor;

        MainContentControl.Content = new DoctorAppointments(_doctorId);
    }

    private void BtnAppointments_Click(object? sender, RoutedEventArgs e)
    {
        MainContentControl.Content = new DoctorAppointments(_doctorId);
    }

    private void BtnPrescriptions_Click(object? sender, RoutedEventArgs e)
    {
        MainContentControl.Content = new DoctorPrescriptions(_doctorId);
    }

    private void BtnReferrals_Click(object? sender, RoutedEventArgs e)
    {
        MainContentControl.Content = new DoctorReferrals(_doctorId);
    }

    private void BtnLogout_Click(object? sender, RoutedEventArgs e)
    {
        var mainW = new MainWindow();
        mainW.Show();
        this.Close();
    }
}