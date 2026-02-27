const OcsfBooleanFilter = @import("ocsf_boolean_filter.zig").OcsfBooleanFilter;
const OcsfDateFilter = @import("ocsf_date_filter.zig").OcsfDateFilter;
const OcsfIpFilter = @import("ocsf_ip_filter.zig").OcsfIpFilter;
const OcsfMapFilter = @import("ocsf_map_filter.zig").OcsfMapFilter;
const OcsfNumberFilter = @import("ocsf_number_filter.zig").OcsfNumberFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;
const OcsfStringFilter = @import("ocsf_string_filter.zig").OcsfStringFilter;

/// Enables the creation of filtering criteria for security findings.
pub const CompositeFilter = struct {
    /// Enables filtering based on boolean field values.
    boolean_filters: ?[]const OcsfBooleanFilter,

    /// Enables filtering based on date and timestamp fields.
    date_filters: ?[]const OcsfDateFilter,

    /// A list of IP address filters that allowing you to filter findings based on
    /// IP address properties.
    ip_filters: ?[]const OcsfIpFilter,

    /// Enables filtering based on map field values.
    map_filters: ?[]const OcsfMapFilter,

    /// Provides an additional level of filtering, creating a three-layer nested
    /// structure.
    /// The first layer is a `CompositeFilters` array with a `CompositeOperator`
    /// (`AND`/`OR`).
    /// The second layer is a `CompositeFilter` object that contains direct filters
    /// and `NestedCompositeFilters`.
    /// The third layer is `NestedCompositeFilters`, which contains additional
    /// filter conditions.
    nested_composite_filters: ?[]const CompositeFilter,

    /// Enables filtering based on numerical field values.
    number_filters: ?[]const OcsfNumberFilter,

    /// The logical operator used to combine multiple filter conditions.
    operator: ?AllowedOperators,

    /// Enables filtering based on string field values.
    string_filters: ?[]const OcsfStringFilter,

    pub const json_field_names = .{
        .boolean_filters = "BooleanFilters",
        .date_filters = "DateFilters",
        .ip_filters = "IpFilters",
        .map_filters = "MapFilters",
        .nested_composite_filters = "NestedCompositeFilters",
        .number_filters = "NumberFilters",
        .operator = "Operator",
        .string_filters = "StringFilters",
    };
};
