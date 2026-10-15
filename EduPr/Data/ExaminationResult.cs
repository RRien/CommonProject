using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class ExaminationResult
{
    public int IdExaminationResult { get; set; }

    public int IdAppointment { get; set; }

    public int IdLabResearch { get; set; }

    public DateTime? ResultDateExam { get; set; }

    public string? ResultsExam { get; set; }

    public string? ConclusionExam { get; set; }

    public virtual Appointment IdAppointmentNavigation { get; set; } = null!;

    public virtual LabResearch IdLabResearchNavigation { get; set; } = null!;
}
