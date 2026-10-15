using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class ResearchReferral
{
    public int IdReferral { get; set; }

    public int IdAppointment { get; set; }

    public int IdLabResearch { get; set; }

    public DateTime? ReferralDateReferral { get; set; }

    public virtual Appointment IdAppointmentNavigation { get; set; } = null!;

    public virtual LabResearch IdLabResearchNavigation { get; set; } = null!;
}
