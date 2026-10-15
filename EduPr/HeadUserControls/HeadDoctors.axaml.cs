using Avalonia;
using Avalonia.Controls;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class HeadDoctors : UserControl
{
    public HeadDoctors()
    {
        InitializeComponent();
        LoadDoctors();
    }

    private void LoadDoctors()
    {
        using var db = new AppDbContext();

        var doctors = db.Doctors
            .Include(d => d.IdSpecializationNavigation)
            .Include(d => d.IdDepartmentNavigation)
            .OrderBy(d => d.LastNameDoctor)
            .ToList();

        DoctorsGrid.ItemsSource = doctors;
    }
}