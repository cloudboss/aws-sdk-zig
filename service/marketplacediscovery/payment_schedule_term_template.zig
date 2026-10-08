const PaymentScheduleEntry = @import("payment_schedule_entry.zig").PaymentScheduleEntry;

/// A template for the payment schedule term on the renewal offer.
pub const PaymentScheduleTermTemplate = struct {
    /// An ordered list of installment entries for the renewal payment schedule.
    schedule: []const PaymentScheduleEntry,

    pub const json_field_names = .{
        .schedule = "schedule",
    };
};
