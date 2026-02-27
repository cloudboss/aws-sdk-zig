const UsageStatisticsSortKey = @import("usage_statistics_sort_key.zig").UsageStatisticsSortKey;
const OrderBy = @import("order_by.zig").OrderBy;

/// Specifies criteria for sorting the results of a query for Amazon Macie
/// account quotas and usage data.
pub const UsageStatisticsSortBy = struct {
    /// The field to sort the results by.
    key: ?UsageStatisticsSortKey,

    /// The sort order to apply to the results, based on the value for the field
    /// specified by the key property. Valid values are: ASC, sort the results in
    /// ascending order; and, DESC, sort the results in descending order.
    order_by: ?OrderBy,

    pub const json_field_names = .{
        .key = "key",
        .order_by = "orderBy",
    };
};
