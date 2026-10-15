using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class PatientAppointments : UserControl
{
    public PatientAppointments(int patientId)
    {
        InitializeComponent();
        LoadData(patientId);
    }
    private void LoadData(int patientId)
    {
        var context = new AppDbContext();
        var appointments = context.Appointments
            .Where(a => a.IdPatient == patientId)
            .Include(a => a.IdDoctorNavigation)
            .Include(a => a.IdServiceNavigation)
            .Include(a => a.IdStatusNavigation)
            .OrderByDescending(a => a.DateAppointment)
            .ToList();

        AppointmentsGrid.ItemsSource = appointments;
    }
}