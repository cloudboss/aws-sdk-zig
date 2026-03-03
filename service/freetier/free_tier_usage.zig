/// Consists of a Amazon Web Services Free Tier offer’s metadata and your data
/// usage for the offer.
pub const FreeTierUsage = struct {
    /// Describes the actual usage accrued month-to-day (MTD) that you've used so
    /// far.
    actual_usage_amount: f64 = 0,

    /// The description of the Free Tier offer.
    description: ?[]const u8 = null,

    /// Describes the forecasted usage by the month that you're expected to use.
    forecasted_usage_amount: f64 = 0,

    /// Describes the type of the Free Tier offer. For example, the offer can be
    /// `"12 Months Free"`, `"Always Free"`, and `"Free Trial"`.
    free_tier_type: ?[]const u8 = null,

    /// Describes the maximum usage allowed in Free Tier.
    limit: f64 = 0,

    /// Describes `usageType` more granularly with the specific Amazon Web Services
    /// service API operation. For example, this can be the `RunInstances` API
    /// operation for Amazon Elastic Compute Cloud.
    operation: ?[]const u8 = null,

    /// Describes the Amazon Web Services Region for which this offer is applicable
    region: ?[]const u8 = null,

    /// The name of the Amazon Web Services service providing the Free Tier offer.
    /// For example, this can be Amazon Elastic Compute Cloud.
    service: ?[]const u8 = null,

    /// Describes the unit of the `usageType`, such as `Hrs`.
    unit: ?[]const u8 = null,

    /// Describes the usage details of the offer. For example, this might be
    /// `Global-BoxUsage:freetrial`.
    usage_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_usage_amount = "actualUsageAmount",
        .description = "description",
        .forecasted_usage_amount = "forecastedUsageAmount",
        .free_tier_type = "freeTierType",
        .limit = "limit",
        .operation = "operation",
        .region = "region",
        .service = "service",
        .unit = "unit",
        .usage_type = "usageType",
    };
};
