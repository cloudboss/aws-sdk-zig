pub const KPISparklineType = enum {
    line,
    area,

    pub const json_field_names = .{
        .line = "LINE",
        .area = "AREA",
    };
};
