pub const EndpointAccessMode = enum {
    basic,
    strict,

    pub const json_field_names = .{
        .basic = "BASIC",
        .strict = "STRICT",
    };
};
