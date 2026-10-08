const PaymentScheduleTermTemplate = @import("payment_schedule_term_template.zig").PaymentScheduleTermTemplate;

/// A structural template defining how a specific term type is reshaped on each
/// renewal cycle. Exactly one variant is present.
pub const TermTemplate = union(enum) {
    /// The installment schedule used to structure payments on the renewal offer.
    payment_schedule_term_template: ?PaymentScheduleTermTemplate,

    pub const json_field_names = .{
        .payment_schedule_term_template = "paymentScheduleTermTemplate",
    };
};
