const ESPartitionInstanceType = @import("es_partition_instance_type.zig").ESPartitionInstanceType;
const ReservedElasticsearchInstancePaymentOption = @import("reserved_elasticsearch_instance_payment_option.zig").ReservedElasticsearchInstancePaymentOption;
const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// Details of a reserved Elasticsearch instance offering.
pub const ReservedElasticsearchInstanceOffering = struct {
    /// The currency code for the reserved Elasticsearch instance offering.
    currency_code: ?[]const u8,

    /// The duration, in seconds, for which the offering will reserve the
    /// Elasticsearch instance.
    duration: i32 = 0,

    /// The Elasticsearch instance type offered by the reserved instance offering.
    elasticsearch_instance_type: ?ESPartitionInstanceType,

    /// The upfront fixed charge you will pay to purchase the specific reserved
    /// Elasticsearch instance offering.
    fixed_price: ?f64,

    /// Payment option for the reserved Elasticsearch instance offering
    payment_option: ?ReservedElasticsearchInstancePaymentOption,

    /// The charge to your account regardless of whether you are creating any
    /// domains using the instance offering.
    recurring_charges: ?[]const RecurringCharge,

    /// The Elasticsearch reserved instance offering identifier.
    reserved_elasticsearch_instance_offering_id: ?[]const u8,

    /// The rate you are charged for each hour the domain that is using the offering
    /// is running.
    usage_price: ?f64,

    pub const json_field_names = .{
        .currency_code = "CurrencyCode",
        .duration = "Duration",
        .elasticsearch_instance_type = "ElasticsearchInstanceType",
        .fixed_price = "FixedPrice",
        .payment_option = "PaymentOption",
        .recurring_charges = "RecurringCharges",
        .reserved_elasticsearch_instance_offering_id = "ReservedElasticsearchInstanceOfferingId",
        .usage_price = "UsagePrice",
    };
};
