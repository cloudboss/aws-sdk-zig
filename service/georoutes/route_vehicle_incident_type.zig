pub const RouteVehicleIncidentType = enum {
    accident,
    congestion,
    construction,
    disabled_vehicle,
    lane_restriction,
    mass_transit,
    other,
    planned_event,
    road_closure,
    road_hazard,
    weather,

    pub const json_field_names = .{
        .accident = "ACCIDENT",
        .congestion = "CONGESTION",
        .construction = "CONSTRUCTION",
        .disabled_vehicle = "DISABLED_VEHICLE",
        .lane_restriction = "LANE_RESTRICTION",
        .mass_transit = "MASS_TRANSIT",
        .other = "OTHER",
        .planned_event = "PLANNED_EVENT",
        .road_closure = "ROAD_CLOSURE",
        .road_hazard = "ROAD_HAZARD",
        .weather = "WEATHER",
    };
};
