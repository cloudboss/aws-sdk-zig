/// The recurring charge to run this reserved node.
pub const RecurringCharge = struct {
    /// The amount of the recurring charge to run this reserved node.
    recurring_charge_amount: f64 = 0,

    /// The frequency of the recurring price charged to run this reserved node.
    recurring_charge_frequency: ?[]const u8,

    pub const json_field_names = .{
        .recurring_charge_amount = "RecurringChargeAmount",
        .recurring_charge_frequency = "RecurringChargeFrequency",
    };
};
