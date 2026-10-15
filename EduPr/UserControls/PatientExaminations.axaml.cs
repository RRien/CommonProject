using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class PatientExaminations : UserControl
{
    public PatientExaminations(int patientId)
    {
        InitializeComponent();
        LoadData(patientId);
    }

    private void LoadData(int patientId)
    {
        var context = new AppDbContext();
        var examinations = context.ExaminationResults
            .Where(e => e.IdAppointmentNavigation.IdPatient == patientId)
            .Include(e => e.IdAppointmentNavigation)
            .Include(e => e.IdLabResearchNavigation)
            .OrderByDescending(e => e.IdAppointmentNavigation.DateAppointment)
            .ToList();

        ExaminationsGrid.ItemsSource = examinations;
    }
}
