const CompositeFilter = @import("composite_filter.zig").CompositeFilter;
const AllowedOperators = @import("allowed_operators.zig").AllowedOperators;

/// Specifies the filtering criteria for security findings using OCSF.
pub const OcsfFindingFilters = struct {
    /// Enables the creation of complex filtering conditions by combining filter
    /// criteria.
    composite_filters: ?[]const CompositeFilter = null,

    /// The logical operators used to combine the filtering on multiple
    /// `CompositeFilters`.
    composite_operator: ?AllowedOperators = null,

    pub const json_field_names = .{
        .composite_filters = "CompositeFilters",
        .composite_operator = "CompositeOperator",
    };
};
