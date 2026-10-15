using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class AppointmentStatus
{
    public int IdStatus { get; set; }

    public string NameStatus { get; set; } = null!;

    public virtual ICollection<Appointment> Appointments { get; } = new List<Appointment>();
}
