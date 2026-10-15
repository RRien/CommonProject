using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using EduPr.Data;

namespace EduPr;

public partial class DoctorReferrals : UserControl
{
    private int _doctorId;

    public DoctorReferrals(int doctorId)
    {
        InitializeComponent();
        _doctorId = doctorId;
        LoadReferrals();
    }

    private void LoadReferrals()
    {
        var db = new AppDbContext();

        var allReferrals = db.ResearchReferrals
            .Include(r => r.IdAppointmentNavigation)
                .ThenInclude(a => a.IdPatientNavigation)
            .Include(r => r.IdLabResearchNavigation)
            .ToList();

        var referrals = allReferrals
            .Where(r => r.IdAppointmentNavigation != null &&
                        r.IdAppointmentNavigation.IdDoctor == _doctorId)
            .OrderByDescending(r => r.ReferralDateReferral)
            .ToList();

        ReferralsGrid.ItemsSource = referrals;
    }

    private async void AddReferral_Click(object? sender, RoutedEventArgs e)
    {
        var card = new DoctorReferralsCard(0, _doctorId);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadReferrals();
    }

    private async void Referral_DoubleTapped(object? sender, TappedEventArgs e)
    {
        var selected = ReferralsGrid.SelectedItem as ResearchReferral;
        if (selected == null) return;

        var card = new DoctorReferralsCard(selected.IdReferral, _doctorId);
        await card.ShowDialog(this.VisualRoot as Window);
        LoadReferrals();
    }
}