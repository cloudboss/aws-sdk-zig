const ResourcesCompositeFilter = @import("resources_composite_filter.zig").ResourcesCompositeFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;

/// Enables filtering of Amazon Web Services resources based on data.
pub const ResourcesFilters = struct {
    /// A collection of complex filtering conditions that can be applied to Amazon
    /// Web Services resources.
    composite_filters: ?[]const ResourcesCompositeFilter = null,

    /// The logical operator used to combine multiple filter conditions in the
    /// structure.
    composite_operator: ?AllowedOperators = null,

    pub const json_field_names = .{
        .composite_filters = "CompositeFilters",
        .composite_operator = "CompositeOperator",
    };
};
