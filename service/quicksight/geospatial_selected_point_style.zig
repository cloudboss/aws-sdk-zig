pub const GeospatialSelectedPointStyle = enum {
    point,
    cluster,
    heatmap,

    pub const json_field_names = .{
        .point = "POINT",
        .cluster = "CLUSTER",
        .heatmap = "HEATMAP",
    };
};
