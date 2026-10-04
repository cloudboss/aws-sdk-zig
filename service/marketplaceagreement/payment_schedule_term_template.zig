const PaymentScheduleEntry = @import("payment_schedule_entry.zig").PaymentScheduleEntry;

/// Defines the payment schedule that is applied to the renewed agreement.
pub const PaymentScheduleTermTemplate = struct {
    /// The installments that make up the payment schedule of the renewed agreement.
    /// The `ChargePercentage` values of all installments add up to `100`.
    schedule: ?[]const PaymentScheduleEntry = null,

    pub const json_field_names = .{
        .schedule = "schedule",
    };
};
