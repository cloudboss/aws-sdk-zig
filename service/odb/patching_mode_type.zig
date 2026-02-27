pub const PatchingModeType = enum {
    rolling,
    nonrolling,

    pub const json_field_names = .{
        .rolling = "ROLLING",
        .nonrolling = "NONROLLING",
    };
};
