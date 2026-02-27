pub const CompromisedCredentialsEventActionType = enum {
    block,
    no_action,

    pub const json_field_names = .{
        .block = "BLOCK",
        .no_action = "NO_ACTION",
    };
};
