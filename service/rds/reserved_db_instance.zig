const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// This data type is used as a response element in the
/// `DescribeReservedDBInstances` and `PurchaseReservedDBInstancesOffering`
/// actions.
pub const ReservedDBInstance = struct {
    /// The currency code for the reserved DB instance.
    currency_code: ?[]const u8 = null,

    /// The DB instance class for the reserved DB instance.
    db_instance_class: ?[]const u8 = null,

    /// The number of reserved DB instances.
    db_instance_count: ?i32 = null,

    /// The duration of the reservation in seconds.
    duration: ?i32 = null,

    /// The fixed price charged for this reserved DB instance.
    fixed_price: ?f64 = null,

    /// The unique identifier for the lease associated with the reserved DB
    /// instance.
    ///
    /// Amazon Web Services Support might request the lease ID for an issue related
    /// to a reserved DB instance.
    lease_id: ?[]const u8 = null,

    /// Indicates whether the reservation applies to Multi-AZ deployments.
    multi_az: ?bool = null,

    /// The offering type of this reserved DB instance.
    offering_type: ?[]const u8 = null,

    /// The description of the reserved DB instance.
    product_description: ?[]const u8 = null,

    /// The recurring price charged to run this reserved DB instance.
    recurring_charges: ?[]const RecurringCharge = null,

    /// The Amazon Resource Name (ARN) for the reserved DB instance.
    reserved_db_instance_arn: ?[]const u8 = null,

    /// The unique identifier for the reservation.
    reserved_db_instance_id: ?[]const u8 = null,

    /// The offering identifier.
    reserved_db_instances_offering_id: ?[]const u8 = null,

    /// The time the reservation started.
    start_time: ?i64 = null,

    /// The state of the reserved DB instance.
    state: ?[]const u8 = null,

    /// The hourly price charged for this reserved DB instance.
    usage_price: ?f64 = null,
};
