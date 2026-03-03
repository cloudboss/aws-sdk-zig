const FindingStatisticsSortAttributeName = @import("finding_statistics_sort_attribute_name.zig").FindingStatisticsSortAttributeName;
const OrderBy = @import("order_by.zig").OrderBy;

/// Specifies criteria for sorting the results of a query that retrieves
/// aggregated statistical data about findings.
pub const FindingStatisticsSortCriteria = struct {
    /// The grouping to sort the results by. Valid values are: count, sort the
    /// results by the number of findings in each group of results; and, groupKey,
    /// sort the results by the name of each group of results.
    attribute_name: ?FindingStatisticsSortAttributeName = null,

    /// The sort order to apply to the results, based on the value for the property
    /// specified by the attributeName property. Valid values are: ASC, sort the
    /// results in ascending order; and, DESC, sort the results in descending order.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .order_by = "orderBy",
    };
};
