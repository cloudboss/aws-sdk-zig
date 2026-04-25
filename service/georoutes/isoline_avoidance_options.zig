const IsolineAvoidanceArea = @import("isoline_avoidance_area.zig").IsolineAvoidanceArea;
const IsolineAvoidanceZoneCategory = @import("isoline_avoidance_zone_category.zig").IsolineAvoidanceZoneCategory;

/// Specifies features of the road network to avoid when calculating reachable
/// areas. These preferences guide route calculations but may be overridden when
/// no reasonable alternative exists. For example, if avoiding toll roads would
/// make an area unreachable, toll roads may still be used.
///
/// Avoidance options include physical features (like ferries and tunnels), road
/// characteristics (like dirt roads and highways), and regulated areas (like
/// congestion zones). They can be combined to match specific routing needs,
/// such as avoiding both toll roads and ferries.
pub const IsolineAvoidanceOptions = struct {
    /// Specifies geographic areas to avoid where possible. Routes may still pass
    /// through these areas if no reasonable alternative exists.
    areas: ?[]const IsolineAvoidanceArea = null,

    /// Indicates a preference to avoid car shuttle trains (auto trains) where
    /// possible. These may still be included if no reasonable alternative route
    /// exists.
    car_shuttle_trains: ?bool = null,

    /// Indicates a preference to avoid controlled-access highways (such as
    /// interstate highways or motorways) where possible. If a viable route cannot
    /// be calculated using only local roads, controlled-access highways may still
    /// be included.
    controlled_access_highways: ?bool = null,

    /// Indicates a preference to avoid unpaved or dirt roads where possible. Routes
    /// may still include dirt roads if no reasonable paved alternative exists.
    dirt_roads: ?bool = null,

    /// Indicates a preference to avoid ferries where possible. If a viable route
    /// cannot be calculated without using ferries, they may still be included.
    ferries: ?bool = null,

    /// Indicates a preference to avoid roads that may be subject to seasonal
    /// closures where possible. These roads may still be included if no reasonable
    /// year-round alternative exists.
    seasonal_closure: ?bool = null,

    /// Indicates a preference to avoid toll roads where possible. If a viable route
    /// cannot be calculated without using toll roads, they may still be included.
    toll_roads: ?bool = null,

    /// Indicates a preference to avoid roads that require electronic toll
    /// collection transponders where possible. These roads may still be included if
    /// no viable alternative route exists.
    toll_transponders: ?bool = null,

    /// For truck travel modes, indicates specific road classification types in
    /// Sweden (` BK1` through `BK4`) and Mexico (`A2, A4, B2, B4, C, D, ET2, ET4`)
    /// to avoid where possible. These road types may still be used if no reasonable
    /// alternative exists.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_types: ?[]const []const u8 = null,

    /// Indicates a preference to avoid tunnels where possible. If a viable route
    /// cannot be calculated without using tunnels, they may still be included.
    tunnels: ?bool = null,

    /// Indicates a preference to avoid U-turns where possible. U-turns may still be
    /// included if necessary to reach certain areas or when no reasonable
    /// alternative exists.
    u_turns: ?bool = null,

    /// Indicates types of regulated zones (such as congestion pricing or
    /// environmental zones) to avoid where possible. Routes may still pass through
    /// these zones if no reasonable alternative exists.
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
