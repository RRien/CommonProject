using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class User
{
    public int IdUser { get; set; }

    public string LoginUser { get; set; } = null!;

    public string PasswordUser { get; set; } = null!;

    public int IdRole { get; set; }

    public virtual Doctor? Doctor { get; set; }

    public virtual Role IdRoleNavigation { get; set; } = null!;
}
