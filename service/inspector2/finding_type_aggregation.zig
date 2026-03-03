const AggregationFindingType = @import("aggregation_finding_type.zig").AggregationFindingType;
const AggregationResourceType = @import("aggregation_resource_type.zig").AggregationResourceType;
const FindingTypeSortBy = @import("finding_type_sort_by.zig").FindingTypeSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;

/// The details that define an aggregation based on finding type.
pub const FindingTypeAggregation = struct {
    /// The finding type to aggregate.
    finding_type: ?AggregationFindingType = null,

    /// The resource type to aggregate.
    resource_type: ?AggregationResourceType = null,

    /// The value to sort results by.
    sort_by: ?FindingTypeSortBy = null,

    /// The order to sort results by.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .finding_type = "findingType",
        .resource_type = "resourceType",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};
