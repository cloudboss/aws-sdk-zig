/// The RDS reserved instances configuration used for recommendations.
pub const RdsReservedInstancesConfiguration = struct {
    /// The account scope for which you want recommendations.
    account_scope: ?[]const u8 = null,

    /// Determines whether the recommendation is for a current generation instance.
    current_generation: ?[]const u8 = null,

    /// The database edition that the recommended reservation supports.
    database_edition: ?[]const u8 = null,

    /// The database engine that the recommended reservation supports.
    database_engine: ?[]const u8 = null,

    /// Determines whether the recommendation is for a reservation in a single
    /// Availability Zone or a reservation with a backup in a second Availability
    /// Zone.
    deployment_option: ?[]const u8 = null,

    /// The instance family of the recommended reservation.
    instance_family: ?[]const u8 = null,

    /// The type of instance that Amazon Web Services recommends.
    instance_type: ?[]const u8 = null,

    /// The license model that the recommended reservation supports.
    license_model: ?[]const u8 = null,

    /// How much purchasing this instance costs you on a monthly basis.
    monthly_recurring_cost: ?[]const u8 = null,

    /// The number of normalized units that Amazon Web Services recommends that you
    /// purchase.
    normalized_units_to_purchase: ?[]const u8 = null,

    /// The number of instances that Amazon Web Services recommends that you
    /// purchase.
    number_of_instances_to_purchase: ?[]const u8 = null,

    /// The payment option for the commitment.
    payment_option: ?[]const u8 = null,

    /// The Amazon Web Services Region of the commitment.
    reserved_instances_region: ?[]const u8 = null,

    /// The service for which you want recommendations.
    service: ?[]const u8 = null,

    /// Determines whether the recommendation is size flexible.
    size_flex_eligible: ?bool = null,

    /// The reserved instances recommendation term in years.
    term: ?[]const u8 = null,

    /// How much purchasing this instance costs you upfront.
    upfront_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .current_generation = "currentGeneration",
        .database_edition = "databaseEdition",
        .database_engine = "databaseEngine",
        .deployment_option = "deploymentOption",
        .instance_family = "instanceFamily",
        .instance_type = "instanceType",
        .license_model = "licenseModel",
        .monthly_recurring_cost = "monthlyRecurringCost",
        .normalized_units_to_purchase = "normalizedUnitsToPurchase",
        .number_of_instances_to_purchase = "numberOfInstancesToPurchase",
        .payment_option = "paymentOption",
        .reserved_instances_region = "reservedInstancesRegion",
        .service = "service",
        .size_flex_eligible = "sizeFlexEligible",
        .term = "term",
        .upfront_cost = "upfrontCost",
    };
};
