pub const BGPStatus = enum {
    up,
    down,
    unknown,

    pub const json_field_names = .{
        .up = "Up",
        .down = "Down",
        .unknown = "Unknown",
    };
};
