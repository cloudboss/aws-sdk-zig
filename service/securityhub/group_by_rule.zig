const OcsfFindingFilters = @import("ocsf_finding_filters.zig").OcsfFindingFilters;
const GroupByField = @import("group_by_field.zig").GroupByField;

/// Defines the how the finding attribute should be grouped.
pub const GroupByRule = struct {
    /// The criteria used to select which security findings should be included in
    /// the grouping operation.
    filters: ?OcsfFindingFilters = null,

    /// The attribute by which filtered findings should be grouped.
    group_by_field: GroupByField,

    pub const json_field_names = .{
        .filters = "Filters",
        .group_by_field = "GroupByField",
    };
};
