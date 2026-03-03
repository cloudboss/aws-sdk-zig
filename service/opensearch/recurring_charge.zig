/// Contains the specific price and frequency of a recurring charges for an
/// OpenSearch
/// Reserved Instance, or for a Reserved Instance offering.
pub const RecurringCharge = struct {
    /// The monetary amount of the recurring charge.
    recurring_charge_amount: ?f64 = null,

    /// The frequency of the recurring charge.
    recurring_charge_frequency: ?[]const u8 = null,

    pub const json_field_names = .{
        .recurring_charge_amount = "RecurringChargeAmount",
        .recurring_charge_frequency = "RecurringChargeFrequency",
    };
};
