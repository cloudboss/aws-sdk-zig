const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// This data type is used as a response element in the
/// `DescribeReservedDBInstancesOfferings` action.
pub const ReservedDBInstancesOffering = struct {
    /// The currency code for the reserved DB instance offering.
    currency_code: ?[]const u8,

    /// The DB instance class for the reserved DB instance.
    db_instance_class: ?[]const u8,

    /// The duration of the offering in seconds.
    duration: ?i32,

    /// The fixed price charged for this offering.
    fixed_price: ?f64,

    /// Indicates whether the offering applies to Multi-AZ deployments.
    multi_az: ?bool,

    /// The offering type.
    offering_type: ?[]const u8,

    /// The database engine used by the offering.
    product_description: ?[]const u8,

    /// The recurring price charged to run this reserved DB instance.
    recurring_charges: ?[]const RecurringCharge,

    /// The offering identifier.
    reserved_db_instances_offering_id: ?[]const u8,

    /// The hourly price charged for this offering.
    usage_price: ?f64,
};
