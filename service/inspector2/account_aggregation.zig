const AggregationFindingType = @import("aggregation_finding_type.zig").AggregationFindingType;
const AggregationResourceType = @import("aggregation_resource_type.zig").AggregationResourceType;
const AccountSortBy = @import("account_sort_by.zig").AccountSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// An object that contains details about an aggregation response based on
/// Amazon Web Services accounts.
pub const AccountAggregation = struct {
    /// The type of finding.
    finding_type: ?AggregationFindingType,

    /// The type of resource.
    resource_type: ?AggregationResourceType,

    /// The value to sort by.
    sort_by: ?AccountSortBy,

    /// The sort order (ascending or descending).
    sort_order: ?SortOrder,

    pub const json_field_names = .{
        .finding_type = "findingType",
        .resource_type = "resourceType",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
