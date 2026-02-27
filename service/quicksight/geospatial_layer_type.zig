pub const GeospatialLayerType = enum {
    point,
    line,
    polygon,

    pub const json_field_names = .{
        .point = "POINT",
        .line = "LINE",
        .polygon = "POLYGON",
    };
};
