pub const RouteSpanScooterAccessAttribute = enum {
    allowed,
    no_through_traffic,
    toll_road,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .no_through_traffic = "NO_THROUGH_TRAFFIC",
        .toll_road = "TOLL_ROAD",
    };
};
