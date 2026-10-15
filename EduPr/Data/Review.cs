using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Review
{
    public int IdReview { get; set; }

    public int IdAppointment { get; set; }

    public int IdPatient { get; set; }

    public int IdDoctor { get; set; }

    public int RatingReview { get; set; }

    public string? CommentReview { get; set; }

    public DateTime? CreatedReview { get; set; }

    public virtual Appointment IdAppointmentNavigation { get; set; } = null!;

    public virtual Doctor IdDoctorNavigation { get; set; } = null!;

    public virtual Patient IdPatientNavigation { get; set; } = null!;
}
