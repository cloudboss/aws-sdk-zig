const Dimension = @import("dimension.zig").Dimension;
const MatchOption = @import("match_option.zig").MatchOption;

/// The metadata that you can use to filter and group your results. You can use
/// `GetDimensionValues` to find specific values.
pub const DimensionValues = struct {
    /// The names of the metadata types that you can use to filter and group your
    /// results. For
    /// example, `AZ` returns a list of Availability Zones.
    ///
    /// Not all dimensions are supported in each API. Refer to the documentation for
    /// each
    /// specific API to see what is supported.
    ///
    /// `LINKED_ACCOUNT_NAME` and `SERVICE_CODE` can only be used in
    /// [CostCategoryRule](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_CostCategoryRule.html).
    ///
    /// `ANOMALY_TOTAL_IMPACT_ABSOLUTE` and
    /// `ANOMALY_TOTAL_IMPACT_PERCENTAGE` can only be used in
    /// [AnomalySubscriptions](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_AnomalySubscription.html).
    key: ?Dimension,

    /// The match options that you can use to filter your results.
    ///
    /// `MatchOptions` is only applicable for actions related to cost category and
    /// Anomaly Subscriptions. Refer to the documentation for each specific API to
    /// see what is
    /// supported.
    ///
    /// The default values for `MatchOptions` are `EQUALS` and
    /// `CASE_SENSITIVE`.
    match_options: ?[]const MatchOption,

    /// The metadata values that you can use to filter and group your results. You
    /// can use
    /// `GetDimensionValues` to find specific values.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
