pub const RouteSpanPedestrianAccessAttribute = enum {
    allowed,
    indoors,
    no_through_traffic,
    park,
    stairs,
    toll_road,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .indoors = "INDOORS",
        .no_through_traffic = "NO_THROUGH_TRAFFIC",
        .park = "PARK",
        .stairs = "STAIRS",
        .toll_road = "TOLL_ROAD",
    };
};
