const LogicalOperator = @import("logical_operator.zig").LogicalOperator;
const PropertyFilter = @import("property_filter.zig").PropertyFilter;

/// A list of PropertyFilter objects.
pub const PropertyFilters = struct {
    /// The Logical Operator used to combine the Property Filters.
    logical_operator: ?LogicalOperator = null,

    /// A list of Property Filters.
    properties: ?[]const PropertyFilter = null,

    pub const json_field_names = .{
        .logical_operator = "LogicalOperator",
        .properties = "Properties",
    };
};
