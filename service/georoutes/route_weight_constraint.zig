const RouteWeightConstraintType = @import("route_weight_constraint_type.zig").RouteWeightConstraintType;

/// The weight constraint for the route.
///
/// **Unit**: `Kilograms`
pub const RouteWeightConstraint = struct {
    /// The type of constraint.
    type: RouteWeightConstraintType,

    /// The constraint value.
    ///
    /// **Unit**: `Kilograms`
    value: i64 = 0,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};
