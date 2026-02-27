pub const RouterOutputType = enum {
    standard,
    mediaconnect_flow,
    medialive_input,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .mediaconnect_flow = "MEDIACONNECT_FLOW",
        .medialive_input = "MEDIALIVE_INPUT",
    };
};
