/// Contains the specific price and frequency of a recurring charges for a
/// reserved cache
/// node, or for a reserved cache node offering.
pub const RecurringCharge = struct {
    /// The monetary amount of the recurring charge.
    recurring_charge_amount: ?f64 = null,

    /// The frequency of the recurring charge.
    recurring_charge_frequency: ?[]const u8 = null,
};
