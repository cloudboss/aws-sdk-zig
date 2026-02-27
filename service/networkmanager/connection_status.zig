pub const ConnectionStatus = enum {
    up,
    down,

    pub const json_field_names = .{
        .up = "UP",
        .down = "DOWN",
    };
};
