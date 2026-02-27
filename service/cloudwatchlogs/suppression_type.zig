pub const SuppressionType = enum {
    limited,
    infinite,

    pub const json_field_names = .{
        .limited = "LIMITED",
        .infinite = "INFINITE",
    };
};
