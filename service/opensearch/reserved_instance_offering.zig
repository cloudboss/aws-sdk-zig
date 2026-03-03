const OpenSearchPartitionInstanceType = @import("open_search_partition_instance_type.zig").OpenSearchPartitionInstanceType;
const ReservedInstancePaymentOption = @import("reserved_instance_payment_option.zig").ReservedInstancePaymentOption;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// Details of an OpenSearch Reserved Instance offering.
pub const ReservedInstanceOffering = struct {
    /// The currency code for the Reserved Instance offering.
    currency_code: ?[]const u8 = null,

    /// The duration, in seconds, for which the offering will reserve the OpenSearch
    /// instance.
    duration: i32 = 0,

    /// The upfront fixed charge you will pay to purchase the specific Reserved
    /// Instance
    /// offering.
    fixed_price: ?f64 = null,

    /// The OpenSearch instance type offered by the Reserved Instance offering.
    instance_type: ?OpenSearchPartitionInstanceType = null,

    /// Payment option for the Reserved Instance offering
    payment_option: ?ReservedInstancePaymentOption = null,

    /// The recurring charge to your account, regardless of whether you creates any
    /// domains
    /// using the offering.
    recurring_charges: ?[]const RecurringCharge = null,

    /// The unique identifier of the Reserved Instance offering.
    reserved_instance_offering_id: ?[]const u8 = null,

    /// The hourly rate at which you're charged for the domain using this Reserved
    /// Instance.
    usage_price: ?f64 = null,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .fixed_price = "FixedPrice",
        .instance_type = "InstanceType",
        .payment_option = "PaymentOption",
        .recurring_charges = "RecurringCharges",
        .reserved_instance_offering_id = "ReservedInstanceOfferingId",
        .usage_price = "UsagePrice",
    };
};
