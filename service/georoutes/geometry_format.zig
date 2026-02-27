pub const GeometryFormat = enum {
    flexible_polyline,
    simple,

    pub const json_field_names = .{
        .flexible_polyline = "FLEXIBLE_POLYLINE",
        .simple = "SIMPLE",
    };
};
