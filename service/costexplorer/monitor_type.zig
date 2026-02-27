pub const MonitorType = enum {
    dimensional,
    custom,

    pub const json_field_names = .{
        .dimensional = "DIMENSIONAL",
        .custom = "CUSTOM",
    };
};
