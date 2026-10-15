using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class PatientPrescriptions : UserControl
{
    public PatientPrescriptions(int patientId)
    {
        InitializeComponent();
        LoadData(patientId);
    }

    private void LoadData(int patientId)
    {
        var context = new AppDbContext();
        var prescriptions = context.MedicationPrescriptions
            .Where(p => p.IdAppointmentNavigation.IdPatient == patientId)
            .Include(p => p.IdAppointmentNavigation)
            .Include(p => p.IdMedicationNavigation)
            .OrderByDescending(p => p.IdAppointmentNavigation.DateAppointment)
            .ToList();

        PrescriptionsGrid.ItemsSource = prescriptions;
    }
}