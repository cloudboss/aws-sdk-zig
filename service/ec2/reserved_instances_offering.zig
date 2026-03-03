const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const Tenancy = @import("tenancy.zig").Tenancy;
const InstanceType = @import("instance_type.zig").InstanceType;
const OfferingClassType = @import("offering_class_type.zig").OfferingClassType;
const OfferingTypeValues = @import("offering_type_values.zig").OfferingTypeValues;
const PricingDetail = @import("pricing_detail.zig").PricingDetail;
const RIProductDescription = @import("ri_product_description.zig").RIProductDescription;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const scope = @import("scope.zig").scope;

/// Describes a Reserved Instance offering.
pub const ReservedInstancesOffering = struct {
    /// The Availability Zone in which the Reserved Instance can be used.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The currency of the Reserved Instance offering you are purchasing. It's
    /// specified using
    /// ISO 4217 standard currency codes. At this time, the only supported currency
    /// is
    /// `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// The duration of the Reserved Instance, in seconds.
    duration: ?i64 = null,

    /// The purchase price of the Reserved Instance.
    fixed_price: ?f32 = null,

    /// The tenancy of the instance.
    instance_tenancy: ?Tenancy = null,

    /// The instance type on which the Reserved Instance can be used.
    instance_type: ?InstanceType = null,

    /// Indicates whether the offering is available through the Reserved Instance
    /// Marketplace
    /// (resale) or Amazon Web Services. If it's a Reserved Instance Marketplace
    /// offering, this is
    /// `true`.
    marketplace: ?bool = null,

    /// If `convertible` it can be exchanged for Reserved Instances of the same or
    /// higher monetary value, with different configurations. If `standard`, it is
    /// not
    /// possible to perform an exchange.
    offering_class: ?OfferingClassType = null,

    /// The Reserved Instance offering type.
    offering_type: ?OfferingTypeValues = null,

    /// The pricing details of the Reserved Instance offering.
    pricing_details: ?[]const PricingDetail = null,

    /// The Reserved Instance product platform description.
    product_description: ?RIProductDescription = null,

    /// The recurring charge tag assigned to the resource.
    recurring_charges: ?[]const RecurringCharge = null,

    /// The ID of the Reserved Instance offering. This is the offering ID used in
    /// GetReservedInstancesExchangeQuote to confirm that an exchange can be
    /// made.
    reserved_instances_offering_id: ?[]const u8 = null,

    /// Whether the Reserved Instance is applied to instances in a Region or an
    /// Availability
    /// Zone.
    scope: ?scope = null,

    /// The usage price of the Reserved Instance, per hour.
    usage_price: ?f32 = null,
};
