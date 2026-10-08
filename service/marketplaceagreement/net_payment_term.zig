/// Defines the net payment due period for the agreement, specifying when
/// payment is due after an invoice is issued.
pub const NetPaymentTerm = struct {
    /// The unique identifier for the term.
    id: ?[]const u8 = null,

    /// The duration after an invoice is issued within which the payment is due. The
    /// duration is represented in the ISO 8601 format (for example, `P30D` for 30
    /// days or `P60D` for 60 days).
    payment_due_period: ?[]const u8 = null,

    /// Type of the term being updated.
    type: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .payment_due_period = "paymentDuePeriod",
        .type = "type",
    };
};
