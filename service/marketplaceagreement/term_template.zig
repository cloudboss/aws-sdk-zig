const PaymentScheduleTermTemplate = @import("payment_schedule_term_template.zig").PaymentScheduleTermTemplate;

/// Defines how a specific type of term changes each time the agreement renews.
/// Exactly one of the following fields is set.
pub const TermTemplate = union(enum) {
    /// Defines the payment schedule that is applied to the renewed agreement.
    payment_schedule_term_template: ?PaymentScheduleTermTemplate,

    pub const json_field_names = .{
        .payment_schedule_term_template = "paymentScheduleTermTemplate",
    };
};
