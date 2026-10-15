using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class SpecialistSchedule
{
    public int IdSpecialistSchedule { get; set; }

    public int IdDoctor { get; set; }

    public int DayOfWeekSchedule { get; set; }

    public TimeOnly StartTimeSchedule { get; set; }

    public TimeOnly EndTimeSchedule { get; set; }

    public virtual Doctor IdDoctorNavigation { get; set; } = null!;
}
