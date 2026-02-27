pub const RouteLegAdditionalFeature = enum {
    elevation,
    incidents,
    pass_through_waypoints,
    summary,
    tolls,
    travel_step_instructions,
    truck_road_types,
    typical_duration,
    zones,

    pub const json_field_names = .{
        .elevation = "ELEVATION",
        .incidents = "INCIDENTS",
        .pass_through_waypoints = "PASS_THROUGH_WAYPOINTS",
        .summary = "SUMMARY",
        .tolls = "TOLLS",
        .travel_step_instructions = "TRAVEL_STEP_INSTRUCTIONS",
        .truck_road_types = "TRUCK_ROAD_TYPES",
        .typical_duration = "TYPICAL_DURATION",
        .zones = "ZONES",
    };
};
