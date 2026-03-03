const CurrencyCodeValues = @import("currency_code_values.zig").CurrencyCodeValues;
const Tenancy = @import("tenancy.zig").Tenancy;
const InstanceType = @import("instance_type.zig").InstanceType;
const OfferingClassType = @import("offering_class_type.zig").OfferingClassType;
const OfferingTypeValues = @import("offering_type_values.zig").OfferingTypeValues;
const RIProductDescription = @import("ri_product_description.zig").RIProductDescription;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const scope = @import("scope.zig").scope;
const ReservedInstanceState = @import("reserved_instance_state.zig").ReservedInstanceState;
const Tag = @import("tag.zig").Tag;

/// Describes a Reserved Instance.
pub const ReservedInstances = struct {
    /// The Availability Zone in which the Reserved Instance can be used.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The currency of the Reserved Instance. It's specified using ISO 4217
    /// standard currency
    /// codes. At this time, the only supported currency is `USD`.
    currency_code: ?CurrencyCodeValues = null,

    /// The duration of the Reserved Instance, in seconds.
    duration: ?i64 = null,

    /// The time when the Reserved Instance expires.
    end: ?i64 = null,

    /// The purchase price of the Reserved Instance.
    fixed_price: ?f32 = null,

    /// The number of reservations purchased.
    instance_count: ?i32 = null,

    /// The tenancy of the instance.
    instance_tenancy: ?Tenancy = null,

    /// The instance type on which the Reserved Instance can be used.
    instance_type: ?InstanceType = null,

    /// The offering class of the Reserved Instance.
    offering_class: ?OfferingClassType = null,

    /// The Reserved Instance offering type.
    offering_type: ?OfferingTypeValues = null,

    /// The Reserved Instance product platform description.
    product_description: ?RIProductDescription = null,

    /// The recurring charge tag assigned to the resource.
    recurring_charges: ?[]const RecurringCharge = null,

    /// The ID of the Reserved Instance.
    reserved_instances_id: ?[]const u8 = null,

    /// The scope of the Reserved Instance.
    scope: ?scope = null,

    /// The date and time the Reserved Instance started.
    start: ?i64 = null,

    /// The state of the Reserved Instance purchase.
    state: ?ReservedInstanceState = null,

    /// Any tags assigned to the resource.
    tags: ?[]const Tag = null,

    /// The usage price of the Reserved Instance, per hour.
    usage_price: ?f32 = null,
};
