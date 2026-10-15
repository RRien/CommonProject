using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Appointment
{
    public int IdAppointment { get; set; }

    public int IdPatient { get; set; }

    public int IdDoctor { get; set; }

    public int IdService { get; set; }

    public DateOnly DateAppointment { get; set; }

    public TimeOnly TimeAppointment { get; set; }

    public int IdCabinet { get; set; }

    public int IdStatus { get; set; }

    public string? ComplaintsAppointment { get; set; }

    public string? DiagnosisAppointment { get; set; }

    public string? RecommendationsAppointment { get; set; }

    public DateTime? CreatedAppointment { get; set; }

    public virtual ICollection<ExaminationResult> ExaminationResults { get; } = new List<ExaminationResult>();

    public virtual Cabinet IdCabinetNavigation { get; set; } = null!;

    public virtual Doctor IdDoctorNavigation { get; set; } = null!;

    public virtual Patient IdPatientNavigation { get; set; } = null!;

    public virtual Service IdServiceNavigation { get; set; } = null!;

    public virtual AppointmentStatus IdStatusNavigation { get; set; } = null!;

    public virtual ICollection<Invoice> Invoices { get; } = new List<Invoice>();

    public virtual ICollection<MedicationPrescription> MedicationPrescriptions { get; } = new List<MedicationPrescription>();

    public virtual ICollection<ResearchReferral> ResearchReferrals { get; } = new List<ResearchReferral>();

    public virtual ICollection<Review> Reviews { get; } = new List<Review>();
}
