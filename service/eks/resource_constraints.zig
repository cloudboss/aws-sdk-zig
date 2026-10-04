const AllowedValuesConstraint = @import("allowed_values_constraint.zig").AllowedValuesConstraint;
const IntegerRangeConstraint = @import("integer_range_constraint.zig").IntegerRangeConstraint;

/// Constraints for resource weight entries.
pub const ResourceConstraints = struct {
    /// The allowed values for resource names.
    name: ?AllowedValuesConstraint = null,

    /// The allowed range for resource weight values.
    weight: ?IntegerRangeConstraint = null,

    pub const json_field_names = .{
        .name = "name",
        .weight = "weight",
    };
};
