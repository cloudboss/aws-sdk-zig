pub const ControlScope = enum {
    global,
    regional,

    pub const json_field_names = .{
        .global = "GLOBAL",
        .regional = "REGIONAL",
    };
};
