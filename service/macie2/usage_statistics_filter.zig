const UsageStatisticsFilterComparator = @import("usage_statistics_filter_comparator.zig").UsageStatisticsFilterComparator;
const UsageStatisticsFilterKey = @import("usage_statistics_filter_key.zig").UsageStatisticsFilterKey;

/// Specifies a condition for filtering the results of a query for quota and
/// usage data for one or more Amazon Macie accounts.
pub const UsageStatisticsFilter = struct {
    /// The operator to use in the condition. If the value for the key property is
    /// accountId, this value must be CONTAINS. If the value for the key property is
    /// any other supported field, this value can be EQ, GT, GTE, LT, LTE, or NE.
    comparator: ?UsageStatisticsFilterComparator = null,

    /// The field to use in the condition.
    key: ?UsageStatisticsFilterKey = null,

    /// An array that lists values to use in the condition, based on the value for
    /// the field specified by the key property. If the value for the key property
    /// is accountId, this array can specify multiple values. Otherwise, this array
    /// can specify only one value.
    ///
    /// Valid values for each supported field are:
    ///
    /// * accountId - The unique identifier for an Amazon Web Services account.
    /// * freeTrialStartDate - The date and time, in UTC and extended ISO 8601
    ///   format, when the Amazon Macie free trial started for an account.
    /// * serviceLimit - A Boolean (true or false) value that indicates whether an
    ///   account has reached its monthly quota.
    /// * total - A string that represents the current estimated cost for an
    ///   account.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .key = "key",
        .values = "values",
    };
};
