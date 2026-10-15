using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class DoctorSchedule
{
    public int IdDoctorSchedule { get; set; }

    public int IdDoctor { get; set; }

    public DateOnly DateSchedule { get; set; }

    public TimeOnly StartTimeSchedule { get; set; }

    public TimeOnly EndTimeSchedule { get; set; }

    public int IdCabinet { get; set; }

    public bool? IsAvailableSchedule { get; set; }

    public virtual Cabinet IdCabinetNavigation { get; set; } = null!;

    public virtual Doctor IdDoctorNavigation { get; set; } = null!;
}
