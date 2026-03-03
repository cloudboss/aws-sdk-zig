const ResourcesFilters = @import("resources_filters.zig").ResourcesFilters;
const ResourceGroupByField = @import("resource_group_by_field.zig").ResourceGroupByField;

/// Defines the configuration for organizing and categorizing Amazon Web
/// Services resources based on associated security findings.
pub const ResourceGroupByRule = struct {
    /// The criteria used to select resources and associated security findings.
    filters: ?ResourcesFilters = null,

    /// Specifies the attribute that resources should be grouped by.
    group_by_field: ResourceGroupByField,

    pub const json_field_names = .{
        .filters = "Filters",
        .group_by_field = "GroupByField",
    };
};
