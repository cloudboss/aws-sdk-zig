pub const RouteSpanRoadAttribute = enum {
    bridge,
    built_up_area,
    controlled_access_highway,
    dirt_road,
    divided_road,
    motorway,
    private_road,
    ramp,
    right_hand_traffic,
    roundabout,
    tunnel,
    under_construction,

    pub const json_field_names = .{
        .bridge = "BRIDGE",
        .built_up_area = "BUILT_UP_AREA",
        .controlled_access_highway = "CONTROLLED_ACCESS_HIGHWAY",
        .dirt_road = "DIRT_ROAD",
        .divided_road = "DIVIDED_ROAD",
        .motorway = "MOTORWAY",
        .private_road = "PRIVATE_ROAD",
        .ramp = "RAMP",
        .right_hand_traffic = "RIGHT_HAND_TRAFFIC",
        .roundabout = "ROUNDABOUT",
        .tunnel = "TUNNEL",
        .under_construction = "UNDER_CONSTRUCTION",
    };
};
