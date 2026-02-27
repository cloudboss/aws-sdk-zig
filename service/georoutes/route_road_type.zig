pub const RouteRoadType = enum {
    highway,
    rural,
    urban,

    pub const json_field_names = .{
        .highway = "HIGHWAY",
        .rural = "RURAL",
        .urban = "URBAN",
    };
};
