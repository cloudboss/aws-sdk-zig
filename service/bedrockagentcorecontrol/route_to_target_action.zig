const StaticRoute = @import("static_route.zig").StaticRoute;
const WeightedRoute = @import("weighted_route.zig").WeightedRoute;

/// An action that routes requests to a gateway target, either statically or
/// with weighted traffic splitting.
pub const RouteToTargetAction = union(enum) {
    /// A static route that sends all matching requests to a single target.
    static_route: ?StaticRoute,
    /// A weighted route that splits traffic between multiple targets.
    weighted_route: ?WeightedRoute,

    pub const json_field_names = .{
        .static_route = "staticRoute",
        .weighted_route = "weightedRoute",
    };
};
