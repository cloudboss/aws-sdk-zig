const ResourcesDateFilter = @import("resources_date_filter.zig").ResourcesDateFilter;
const ResourcesMapFilter = @import("resources_map_filter.zig").ResourcesMapFilter;
const ResourcesNumberFilter = @import("resources_number_filter.zig").ResourcesNumberFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;
const ResourcesStringFilter = @import("resources_string_filter.zig").ResourcesStringFilter;

/// Enables the creation of criteria for Amazon Web Services resources in
/// Security Hub.
pub const ResourcesCompositeFilter = struct {
    /// Enables filtering based on date and timestamp field values.
    date_filters: ?[]const ResourcesDateFilter,

    /// Enables filtering based on map-based field values.
    map_filters: ?[]const ResourcesMapFilter,

    /// Provides an additional level of filtering, creating a three-layer nested
    /// structure.
    /// The first layer is a `CompositeFilters` array with a `CompositeOperator`
    /// (`AND`/`OR`).
    /// The second layer is a `CompositeFilter` object that contains direct filters
    /// and `NestedCompositeFilters`.
    /// The third layer is `NestedCompositeFilters`, which contains additional
    /// filter conditions.
    nested_composite_filters: ?[]const ResourcesCompositeFilter,

    /// Enables filtering based on numerical field values.
    number_filters: ?[]const ResourcesNumberFilter,

    /// The logical operator used to combine multiple filter conditions.
    operator: ?AllowedOperators,

    /// Enables filtering based on string field values.
    string_filters: ?[]const ResourcesStringFilter,

    pub const json_field_names = .{
        .date_filters = "DateFilters",
        .map_filters = "MapFilters",
        .nested_composite_filters = "NestedCompositeFilters",
        .number_filters = "NumberFilters",
        .operator = "Operator",
        .string_filters = "StringFilters",
    };
};
