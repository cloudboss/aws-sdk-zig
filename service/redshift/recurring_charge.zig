/// Describes a recurring charge.
pub const RecurringCharge = struct {
    /// The amount charged per the period of time specified by the recurring charge
    /// frequency.
    recurring_charge_amount: ?f64,

    /// The frequency at which the recurring charge amount is applied.
    recurring_charge_frequency: ?[]const u8,
};
