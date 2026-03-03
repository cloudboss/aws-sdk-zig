const RouteAvoidanceArea = @import("route_avoidance_area.zig").RouteAvoidanceArea;
const RouteAvoidanceZoneCategory = @import("route_avoidance_zone_category.zig").RouteAvoidanceZoneCategory;

/// Specifies options for areas to avoid when calculating the route. This is a
/// best-effort avoidance setting, meaning the router will try to honor the
/// avoidance preferences but may still include restricted areas if no feasible
/// alternative route exists. If avoidance options are not followed, the
/// response will indicate that the avoidance criteria were violated.
pub const RouteAvoidanceOptions = struct {
    /// Areas to be avoided.
    areas: ?[]const RouteAvoidanceArea = null,

    /// Avoid car-shuttle-trains while calculating the route.
    car_shuttle_trains: ?bool = null,

    /// Avoid controlled access highways while calculating the route.
    controlled_access_highways: ?bool = null,

    /// Avoid dirt roads while calculating the route.
    dirt_roads: ?bool = null,

    /// Avoid ferries while calculating the route.
    ferries: ?bool = null,

    /// Avoid roads that have seasonal closure while calculating the route.
    seasonal_closure: ?bool = null,

    /// Avoids roads where the specified toll transponders are the only mode of
    /// payment.
    toll_roads: ?bool = null,

    /// Avoids roads where the specified toll transponders are the only mode of
    /// payment.
    toll_transponders: ?bool = null,

    /// Truck road type identifiers. `BK1` through `BK4` apply only to Sweden.
    /// `A2,A4,B2,B4,C,D,ET2,ET4` apply only to Mexico.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_types: ?[]const []const u8 = null,

    /// Avoid tunnels while calculating the route.
    tunnels: ?bool = null,

    /// Avoid U-turns for calculation on highways and motorways.
    u_turns: ?bool = null,

    /// Zone categories to be avoided.
    zone_categories: ?[]const RouteAvoidanceZoneCategory = null,

    pub const json_field_names = .{
        .areas = "Areas",
        .car_shuttle_trains = "CarShuttleTrains",
        .controlled_access_highways = "ControlledAccessHighways",
        .dirt_roads = "DirtRoads",
        .ferries = "Ferries",
        .seasonal_closure = "SeasonalClosure",
        .toll_roads = "TollRoads",
        .toll_transponders = "TollTransponders",
        .truck_road_types = "TruckRoadTypes",
        .tunnels = "Tunnels",
        .u_turns = "UTurns",
        .zone_categories = "ZoneCategories",
    };
};
