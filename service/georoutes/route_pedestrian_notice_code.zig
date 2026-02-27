pub const RoutePedestrianNoticeCode = enum {
    accurate_polyline_unavailable,
    other,
    violated_avoid_dirt_road,
    violated_avoid_tunnel,
    violated_pedestrian_option,

    pub const json_field_names = .{
        .accurate_polyline_unavailable = "ACCURATE_POLYLINE_UNAVAILABLE",
        .other = "OTHER",
        .violated_avoid_dirt_road = "VIOLATED_AVOID_DIRT_ROAD",
        .violated_avoid_tunnel = "VIOLATED_AVOID_TUNNEL",
        .violated_pedestrian_option = "VIOLATED_PEDESTRIAN_OPTION",
    };
};
