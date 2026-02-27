const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;
const ReservedInstancePaymentOption = @import("reserved_instance_payment_option.zig").ReservedInstancePaymentOption;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// Details of an OpenSearch Reserved Instance.
pub const ReservedInstance = struct {
    /// The unique identifier of the billing subscription.
    billing_subscription_id: ?i64,

    /// The currency code for the offering.
    currency_code: ?[]const u8,

    /// The duration, in seconds, for which the OpenSearch instance is reserved.
    duration: i32 = 0,

    /// The upfront fixed charge you will paid to purchase the specific Reserved
    /// Instance
    /// offering.
    fixed_price: ?f64,

    /// The number of OpenSearch instances that have been reserved.
    instance_count: i32 = 0,

    /// The OpenSearch instance type offered by theReserved Instance offering.
    instance_type: ?OpenSearchPartitionInstanceType,

    /// The payment option as defined in the Reserved Instance offering.
    payment_option: ?ReservedInstancePaymentOption,

    /// The recurring charge to your account, regardless of whether you create any
    /// domains
    /// using the Reserved Instance offering.
    recurring_charges: ?[]const RecurringCharge,

    /// The customer-specified identifier to track this reservation.
    reservation_name: ?[]const u8,

    /// The unique identifier for the reservation.
    reserved_instance_id: ?[]const u8,

    /// The unique identifier of the Reserved Instance offering.
    reserved_instance_offering_id: ?[]const u8,

    /// The date and time when the reservation was purchased.
    start_time: ?i64,

    /// The state of the Reserved Instance.
    state: ?[]const u8,

    /// The hourly rate at which you're charged for the domain using this Reserved
    /// Instance.
    usage_price: ?f64,

    pub const json_field_names = .{
        .billing_subscription_id = "BillingSubscriptionId",
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .fixed_price = "FixedPrice",
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
        .payment_option = "PaymentOption",
        .recurring_charges = "RecurringCharges",
        .reservation_name = "ReservationName",
        .reserved_instance_id = "ReservedInstanceId",
        .reserved_instance_offering_id = "ReservedInstanceOfferingId",
        .start_time = "StartTime",
        .state = "State",
        .usage_price = "UsagePrice",
    };
};
