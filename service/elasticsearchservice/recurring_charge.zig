/// Contains the specific price and frequency of a recurring charges for a
/// reserved Elasticsearch instance, or for a reserved Elasticsearch instance
/// offering.
pub const RecurringCharge = struct {
    /// The monetary amount of the recurring charge.
    recurring_charge_amount: ?f64,

    /// The frequency of the recurring charge.
    recurring_charge_frequency: ?[]const u8,

    pub const json_field_names = .{
        .recurring_charge_amount = "RecurringChargeAmount",
        .recurring_charge_frequency = "RecurringChargeFrequency",
    };
};
