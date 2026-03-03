const MonetaryAmount = @import("monetary_amount.zig").MonetaryAmount;
const RecurringChargeFrequency = @import("recurring_charge_frequency.zig").RecurringChargeFrequency;

/// Specifies whether charges for devices are recurring.
pub const RecurringCharge = struct {
    /// The cost of the recurring charge.
    cost: ?MonetaryAmount = null,

    /// The frequency in which charges recur.
    frequency: ?RecurringChargeFrequency = null,

    pub const json_field_names = .{
        .cost = "cost",
        .frequency = "frequency",
    };
};
