const ResourcesDateFilter = @import("resources_date_filter.zig").ResourcesDateFilter;
const ResourcesMapFilter = @import("resources_map_filter.zig").ResourcesMapFilter;
const ResourcesNumberFilter = @import("resources_number_filter.zig").ResourcesNumberFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;
const ResourcesStringFilter = @import("resources_string_filter.zig").ResourcesStringFilter;

/// Enables the creation of criteria for Amazon Web Services resources in
/// Security Hub CSPM.
pub const ResourcesCompositeFilter = struct {
    /// Enables filtering based on date and timestamp field values.
    date_filters: ?[]const ResourcesDateFilter = null,

    /// Enables filtering based on map-based field values.
    map_filters: ?[]const ResourcesMapFilter = null,

    /// Provides an additional level of filtering, creating a three-layer nested
    /// structure.
    /// The first layer is a `CompositeFilters` array with a `CompositeOperator`
    /// (`AND`/`OR`).
    /// The second layer is a `CompositeFilter` object that contains direct filters
    /// and `NestedCompositeFilters`.
    /// The third layer is `NestedCompositeFilters`, which contains additional
    /// filter conditions.
    nested_composite_filters: ?[]const ResourcesCompositeFilter = null,

    /// Enables filtering based on numerical field values.
    number_filters: ?[]const ResourcesNumberFilter = null,

    /// The logical operator used to combine multiple filter conditions.
    operator: ?AllowedOperators = null,

    /// Enables filtering based on string field values.
    string_filters: ?[]const ResourcesStringFilter = null,

    pub const json_field_names = .{
        .date_filters = "DateFilters",
        .map_filters = "MapFilters",
        .nested_composite_filters = "NestedCompositeFilters",
        .number_filters = "NumberFilters",
        .operator = "Operator",
        .string_filters = "StringFilters",
    };
};
