/// The EC2 reserved instances configuration used for recommendations.
pub const Ec2ReservedInstancesConfiguration = struct {
    /// The account scope for which you want recommendations.
    account_scope: ?[]const u8,

    /// Determines whether the recommendation is for a current generation instance.
    current_generation: ?[]const u8,

    /// The instance family of the recommended reservation.
    instance_family: ?[]const u8,

    /// The type of instance that Amazon Web Services recommends.
    instance_type: ?[]const u8,

    /// How much purchasing these reserved instances costs you on a monthly basis.
    monthly_recurring_cost: ?[]const u8,

    /// The number of normalized units that Amazon Web Services recommends that you
    /// purchase.
    normalized_units_to_purchase: ?[]const u8,

    /// The number of instances that Amazon Web Services recommends that you
    /// purchase.
    number_of_instances_to_purchase: ?[]const u8,

    /// Indicates whether the recommendation is for standard or convertible
    /// reservations.
    offering_class: ?[]const u8,

    /// The payment option for the commitment.
    payment_option: ?[]const u8,

    /// The platform of the recommended reservation. The platform is the specific
    /// combination of operating system, license model, and software on an instance.
    platform: ?[]const u8,

    /// The Amazon Web Services Region of the commitment.
    reserved_instances_region: ?[]const u8,

    /// The service for which you want recommendations.
    service: ?[]const u8,

    /// Determines whether the recommendation is size flexible.
    size_flex_eligible: ?bool,

    /// Determines whether the recommended reservation is dedicated or shared.
    tenancy: ?[]const u8,

    /// The reserved instances recommendation term in years.
    term: ?[]const u8,

    /// How much purchasing this instance costs you upfront.
    upfront_cost: ?[]const u8,

    pub const json_field_names = .{
        .account_scope = "accountScope",
        .current_generation = "currentGeneration",
        .instance_family = "instanceFamily",
        .instance_type = "instanceType",
        .monthly_recurring_cost = "monthlyRecurringCost",
        .normalized_units_to_purchase = "normalizedUnitsToPurchase",
        .number_of_instances_to_purchase = "numberOfInstancesToPurchase",
        .offering_class = "offeringClass",
        .payment_option = "paymentOption",
        .platform = "platform",
        .reserved_instances_region = "reservedInstancesRegion",
        .service = "service",
        .size_flex_eligible = "sizeFlexEligible",
        .tenancy = "tenancy",
        .term = "term",
        .upfront_cost = "upfrontCost",
    };
};
