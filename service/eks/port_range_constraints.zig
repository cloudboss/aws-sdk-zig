const IntegerRangeConstraint = @import("integer_range_constraint.zig").IntegerRangeConstraint;

/// Constraints for a port range parameter.
pub const PortRangeConstraints = struct {
    /// The constraints for the maximum port value.
    max_port: ?IntegerRangeConstraint = null,

    /// The constraints for the minimum port value.
    min_port: ?IntegerRangeConstraint = null,

    pub const json_field_names = .{
        .max_port = "maxPort",
        .min_port = "minPort",
    };
};
