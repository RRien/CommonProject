using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using EduPr.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq;

namespace EduPr;

public partial class ReviewList : UserControl
{
    public ReviewList()
    {
        InitializeComponent(); 
        LoadReviews("");
    }

    private void LoadReviews(string searchText)
    {
        var db = new AppDbContext();
        var reviews = db.Reviews
            .Include(r => r.IdPatientNavigation)
            .Include(r => r.IdDoctorNavigation)
            .ToList();

        if (!string.IsNullOrWhiteSpace(searchText))
        {
            reviews = reviews.Where(r =>
                (r.IdPatientNavigation?.LastNamePatient?.Contains(searchText) ?? false) ||
                (r.IdPatientNavigation?.FirstNamePatient?.Contains(searchText) ?? false) ||
                (r.IdDoctorNavigation?.LastNameDoctor?.Contains(searchText) ?? false) ||
                (r.IdDoctorNavigation?.FirstNameDoctor?.Contains(searchText) ?? false)
            ).ToList();
        }

        ReviewsGrid.ItemsSource = reviews.OrderByDescending(r => r.CreatedReview).ToList();
    }

    private void Search_TextChanged(object? sender, TextChangedEventArgs e)
    {
        LoadReviews(searchTb.Text);
    }

    private void Search_Click(object? sender, RoutedEventArgs e)
    {
        LoadReviews(searchTb.Text);
    }
}