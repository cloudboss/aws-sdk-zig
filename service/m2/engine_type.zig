pub const EngineType = enum {
    microfocus,
    bluage,

    pub const json_field_names = .{
        .microfocus = "MICROFOCUS",
        .bluage = "BLUAGE",
    };
};
