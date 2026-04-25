const RouteWeightConstraintType = @import("route_weight_constraint_type.zig").RouteWeightConstraintType;

/// The weight constraint for the route.
///
/// **Unit**: `kilograms`
pub const RouteWeightConstraint = struct {
    /// The type of constraint.
    @"type": RouteWeightConstraintType,

    /// The constraint value.
    ///
    /// **Unit**: `kilograms`
    value: i64 = 0,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value = "Value",
    };
};
