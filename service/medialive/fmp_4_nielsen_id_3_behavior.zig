/// Fmp4 Nielsen Id3 Behavior
pub const Fmp4NielsenId3Behavior = enum {
    no_passthrough,
    passthrough,

    pub const json_field_names = .{
        .no_passthrough = "NO_PASSTHROUGH",
        .passthrough = "PASSTHROUGH",
    };
};
