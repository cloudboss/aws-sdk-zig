const TermType = @import("term_type.zig").TermType;

/// Defines a net payment term that sets how many days after the invoice date
/// the payment is due.
pub const NetPaymentTerm = struct {
    /// The unique identifier of the term.
    id: []const u8,

    /// The duration after invoice date by which payment is due.
    payment_due_period: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .id = "id",
        .payment_due_period = "paymentDuePeriod",
        .type = "type",
    };
};
