using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Service
{
    public int IdService { get; set; }

    public string NameService { get; set; } = null!;

    public decimal CostService { get; set; }

    public int DurationMinutesService { get; set; }

    public string? RequirementsService { get; set; }

    public int IdServiceType { get; set; }

    public virtual ICollection<Appointment> Appointments { get; } = new List<Appointment>();

    public virtual ServiceType IdServiceTypeNavigation { get; set; } = null!;
}
