using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorPrescriptions : UserControl
{
    private int _doctorId;

    public DoctorPrescriptions(int doctorId)
    {
        InitializeComponent();
        _doctorId = doctorId;
        LoadPrescriptions();
    }
    private void LoadPrescriptions()
    {
        var db = new AppDbContext();

        var allPrescriptions = db.MedicationPrescriptions
            .Include(p => p.IdAppointmentNavigation)
             .ThenInclude(a => a.IdPatientNavigation)
            .Include(p => p.IdMedicationNavigation)
            .ToList();

        var prescriptions = allPrescriptions
            .Where(p => p.IdAppointmentNavigation != null &&
                       p.IdAppointmentNavigation.IdDoctor == _doctorId)
            .OrderBy(p => p.IdAppointmentNavigation.DateAppointment)
            .ThenBy(p => p.IdAppointmentNavigation.TimeAppointment)
            .ToList();

        PrescriptionsGrid.ItemsSource = prescriptions;
    }


    private async void AddPrescription_Click(object? sender, RoutedEventArgs e)
    {
        var card = new DoctorPrescriptionCard(0, _doctorId);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadPrescriptions();
    }

    private async void Prescription_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selected = PrescriptionsGrid.SelectedItem as MedicationPrescription;
        if (selected == null) return;

        var card = new DoctorPrescriptionCard(selected.IdPrescription, _doctorId);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadPrescriptions();
    }
}
