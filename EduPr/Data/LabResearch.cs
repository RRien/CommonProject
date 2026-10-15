using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class LabResearch
{
    public int IdLabResearch { get; set; }

    public string NameLabResearch { get; set; } = null!;

    public decimal CostLabResearch { get; set; }

    public virtual ICollection<ExaminationResult> ExaminationResults { get; } = new List<ExaminationResult>();

    public virtual ICollection<ResearchReferral> ResearchReferrals { get; } = new List<ResearchReferral>();
}
