pub const DisassociateModeEnum = enum {
    force,
    no_force,

    pub const json_field_names = .{
        .force = "FORCE",
        .no_force = "NO_FORCE",
    };
};
