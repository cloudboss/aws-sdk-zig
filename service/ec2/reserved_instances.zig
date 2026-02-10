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
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// The currency of the Reserved Instance. It's specified using ISO 4217
    /// standard currency
    /// codes. At this time, the only supported currency is `USD`.
    currency_code: ?CurrencyCodeValues,

    /// The duration of the Reserved Instance, in seconds.
    duration: ?i64,

    /// The time when the Reserved Instance expires.
    end: ?i64,

    /// The purchase price of the Reserved Instance.
    fixed_price: ?f32,

    /// The number of reservations purchased.
    instance_count: ?i32,

    /// The tenancy of the instance.
    instance_tenancy: ?Tenancy,

    /// The instance type on which the Reserved Instance can be used.
    instance_type: ?InstanceType,

    /// The offering class of the Reserved Instance.
    offering_class: ?OfferingClassType,

    /// The Reserved Instance offering type.
    offering_type: ?OfferingTypeValues,

    /// The Reserved Instance product platform description.
    product_description: ?RIProductDescription,

    /// The recurring charge tag assigned to the resource.
    recurring_charges: ?[]const RecurringCharge,

    /// The ID of the Reserved Instance.
    reserved_instances_id: ?[]const u8,

    /// The scope of the Reserved Instance.
    scope: ?scope,

    /// The date and time the Reserved Instance started.
    start: ?i64,

    /// The state of the Reserved Instance purchase.
    state: ?ReservedInstanceState,

    /// Any tags assigned to the resource.
    tags: ?[]const Tag,

    /// The usage price of the Reserved Instance, per hour.
    usage_price: ?f32,
};
