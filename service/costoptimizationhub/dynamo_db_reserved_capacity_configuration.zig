/// The DynamoDB reserved capacity configuration used for recommendations.
pub const DynamoDbReservedCapacityConfiguration = struct {
    /// The account scope for which you want recommendations.
    account_scope: ?[]const u8,

    /// The capacity unit of the recommended reservation.
    capacity_units: ?[]const u8,

    /// How much purchasing this reserved capacity costs you on a monthly basis.
    monthly_recurring_cost: ?[]const u8,

    /// The number of reserved capacity units that Amazon Web Services recommends
    /// that you purchase.
    number_of_capacity_units_to_purchase: ?[]const u8,

    /// The payment option for the commitment.
    payment_option: ?[]const u8,

    /// The Amazon Web Services Region of the commitment.
    reserved_instances_region: ?[]const u8,

    /// The service for which you want recommendations.
    service: ?[]const u8,

    /// The reserved capacity recommendation term in years.
    term: ?[]const u8,

    /// How much purchasing this reserved capacity costs you upfront.
    upfront_cost: ?[]const u8,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .capacity_units = "capacityUnits",
        .monthly_recurring_cost = "monthlyRecurringCost",
        .number_of_capacity_units_to_purchase = "numberOfCapacityUnitsToPurchase",
        .payment_option = "paymentOption",
        .reserved_instances_region = "reservedInstancesRegion",
        .service = "service",
        .term = "term",
        .upfront_cost = "upfrontCost",
    };
};
