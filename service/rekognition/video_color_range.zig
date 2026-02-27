pub const VideoColorRange = enum {
    full,
    limited,

    pub const json_field_names = .{
        .full = "FULL",
        .limited = "LIMITED",
    };
};
