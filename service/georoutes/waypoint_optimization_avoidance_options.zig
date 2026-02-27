const WaypointOptimizationAvoidanceArea = @import("waypoint_optimization_avoidance_area.zig").WaypointOptimizationAvoidanceArea;

/// Specifies options for areas to avoid. This is a best-effort avoidance
/// setting, meaning the router will try to honor the avoidance preferences but
/// may still include restricted areas if no feasible alternative route exists.
/// If avoidance options are not followed, the response will indicate that the
/// avoidance criteria were violated.
pub const WaypointOptimizationAvoidanceOptions = struct {
    /// Areas to be avoided.
    areas: ?[]const WaypointOptimizationAvoidanceArea,

    /// Avoidance options for cars-shuttles-trains.
    car_shuttle_trains: ?bool,

    /// Avoid controlled access highways while calculating the route.
    controlled_access_highways: ?bool,

    /// Avoid dirt roads while calculating the route.
    dirt_roads: ?bool,

    /// Avoidance options for ferries.
    ferries: ?bool,

    /// Avoids roads where the specified toll transponders are the only mode of
    /// payment.
    toll_roads: ?bool,

    /// Avoid tunnels while calculating the route.
    tunnels: ?bool,

    /// Avoid U-turns for calculation on highways and motorways.
    u_turns: ?bool,

    pub const json_field_names = .{
        .areas = "Areas",
        .car_shuttle_trains = "CarShuttleTrains",
        .controlled_access_highways = "ControlledAccessHighways",
        .dirt_roads = "DirtRoads",
        .ferries = "Ferries",
        .toll_roads = "TollRoads",
        .tunnels = "Tunnels",
        .u_turns = "UTurns",
    };
};
