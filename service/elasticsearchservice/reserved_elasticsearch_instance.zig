const ESPartitionInstanceType = @import("es_partition_instance_type.zig").ESPartitionInstanceType;
const ReservedElasticsearchInstancePaymentOption = @import("reserved_elasticsearch_instance_payment_option.zig").ReservedElasticsearchInstancePaymentOption;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// Details of a reserved Elasticsearch instance.
pub const ReservedElasticsearchInstance = struct {
    /// The currency code for the reserved Elasticsearch instance offering.
    currency_code: ?[]const u8,

    /// The duration, in seconds, for which the Elasticsearch instance is reserved.
    duration: i32 = 0,

    /// The number of Elasticsearch instances that have been reserved.
    elasticsearch_instance_count: i32 = 0,

    /// The Elasticsearch instance type offered by the reserved instance offering.
    elasticsearch_instance_type: ?ESPartitionInstanceType,

    /// The upfront fixed charge you will paid to purchase the specific reserved
    /// Elasticsearch instance offering.
    fixed_price: ?f64,

    /// The payment option as defined in the reserved Elasticsearch instance
    /// offering.
    payment_option: ?ReservedElasticsearchInstancePaymentOption,

    /// The charge to your account regardless of whether you are creating any
    /// domains using the instance offering.
    recurring_charges: ?[]const RecurringCharge,

    /// The customer-specified identifier to track this reservation.
    reservation_name: ?[]const u8,

    /// The unique identifier for the reservation.
    reserved_elasticsearch_instance_id: ?[]const u8,

    /// The offering identifier.
    reserved_elasticsearch_instance_offering_id: ?[]const u8,

    /// The time the reservation started.
    start_time: ?i64,

    /// The state of the reserved Elasticsearch instance.
    state: ?[]const u8,

    /// The rate you are charged for each hour for the domain that is using this
    /// reserved instance.
    usage_price: ?f64,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .elasticsearch_instance_count = "ElasticsearchInstanceCount",
        .elasticsearch_instance_type = "ElasticsearchInstanceType",
        .fixed_price = "FixedPrice",
        .payment_option = "PaymentOption",
        .recurring_charges = "RecurringCharges",
        .reservation_name = "ReservationName",
        .reserved_elasticsearch_instance_id = "ReservedElasticsearchInstanceId",
        .reserved_elasticsearch_instance_offering_id = "ReservedElasticsearchInstanceOfferingId",
        .start_time = "StartTime",
        .state = "State",
        .usage_price = "UsagePrice",
    };
};
