/// Input Source End Behavior
pub const InputSourceEndBehavior = enum {
    @"continue",
    loop,

    pub const json_field_names = .{
        .@"continue" = "CONTINUE",
        .loop = "LOOP",
    };
};
