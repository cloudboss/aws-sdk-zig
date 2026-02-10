const RecurringChargeFrequency = @import("recurring_charge_frequency.zig").RecurringChargeFrequency;

/// Describes a recurring charge.
pub const RecurringCharge = struct {
    /// The amount of the recurring charge.
    amount: ?f64,

    /// The frequency of the recurring charge.
    frequency: ?RecurringChargeFrequency,
};
