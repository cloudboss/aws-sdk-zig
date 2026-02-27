pub const TrackingServerSize = enum {
    s,
    m,
    l,

    pub const json_field_names = .{
        .s = "S",
        .m = "M",
        .l = "L",
    };
};
