pub const FiberOpticCableType = enum {
    single_mode,
    multi_mode,

    pub const json_field_names = .{
        .single_mode = "SINGLE_MODE",
        .multi_mode = "MULTI_MODE",
    };
};
