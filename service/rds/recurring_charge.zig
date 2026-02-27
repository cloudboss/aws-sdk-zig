/// This data type is used as a response element in the
/// `DescribeReservedDBInstances` and `DescribeReservedDBInstancesOfferings`
/// actions.
pub const RecurringCharge = struct {
    /// The amount of the recurring charge.
    recurring_charge_amount: ?f64,

    /// The frequency of the recurring charge.
    recurring_charge_frequency: ?[]const u8,
};
