const AggregationFindingType = @import("aggregation_finding_type.zig").AggregationFindingType;
const AggregationResourceType = @import("aggregation_resource_type.zig").AggregationResourceType;
const TitleSortBy = @import("title_sort_by.zig").TitleSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const StringFilter = @import("string_filter.zig").StringFilter;

/// The details that define an aggregation based on finding title.
pub const TitleAggregation = struct {
    /// The type of finding to aggregate on.
    finding_type: ?AggregationFindingType,

    /// The resource type to aggregate on.
    resource_type: ?AggregationResourceType,

    /// The value to sort results by.
    sort_by: ?TitleSortBy,

    /// The order to sort results by.
    sort_order: ?SortOrder,

    /// The finding titles to aggregate on.
    titles: ?[]const StringFilter,

    /// The vulnerability IDs of the findings.
    vulnerability_ids: ?[]const StringFilter,

    pub const json_field_names = .{
        .finding_type = "findingType",
        .resource_type = "resourceType",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
        .titles = "titles",
        .vulnerability_ids = "vulnerabilityIds",
    };
};
