const IsolineAvoidanceArea = @import("isoline_avoidance_area.zig").IsolineAvoidanceArea;
const IsolineAvoidanceZoneCategory = @import("isoline_avoidance_zone_category.zig").IsolineAvoidanceZoneCategory;

/// Features that are avoided while calculating isolines. Avoidance is on a
/// best-case basis. If an avoidance can't be satisfied for a particular case,
/// it violates the avoidance and the returned response produces a notice for
/// the violation.
pub const IsolineAvoidanceOptions = struct {
    /// Areas to be avoided.
    areas: ?[]const IsolineAvoidanceArea = null,

    /// Avoid car-shuttle-trains while calculating an isoline.
    car_shuttle_trains: ?bool = null,

    /// Avoid controlled access highways while calculating an isoline.
    controlled_access_highways: ?bool = null,

    /// Avoid dirt roads while calculating an isoline.
    dirt_roads: ?bool = null,

    /// Avoid ferries while calculating an isoline.
    ferries: ?bool = null,

    /// Avoid roads that have seasonal closure while calculating an isoline.
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

    /// Avoid tunnels while calculating an isoline.
    tunnels: ?bool = null,

    /// Avoid U-turns for calculation on highways and motorways.
    u_turns: ?bool = null,

    /// Zone categories to be avoided.
    zone_categories: ?[]const IsolineAvoidanceZoneCategory = null,

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
