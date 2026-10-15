using System;
using System.Collections.Generic;

namespace EduPr.Data;

public partial class Invoice
{
    public int IdInvoice { get; set; }

    public int IdPatient { get; set; }

    public int? IdAppointment { get; set; }

    public DateTime? IssueDateInvoice { get; set; }

    public decimal TotalAmountInvoice { get; set; }

    public decimal? DiscountInvoice { get; set; }

    public decimal FinalAmountInvoice { get; set; }

    public int IdPaymentStatus { get; set; }

    public virtual Appointment? IdAppointmentNavigation { get; set; }

    public virtual Patient IdPatientNavigation { get; set; } = null!;

    public virtual PaymentStatus IdPaymentStatusNavigation { get; set; } = null!;
}
