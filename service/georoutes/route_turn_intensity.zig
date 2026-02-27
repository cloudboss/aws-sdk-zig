pub const RouteTurnIntensity = enum {
    sharp,
    slight,
    typical,

    pub const json_field_names = .{
        .sharp = "SHARP",
        .slight = "SLIGHT",
        .typical = "TYPICAL",
    };
};
