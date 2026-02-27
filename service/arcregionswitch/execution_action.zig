pub const ExecutionAction = enum {
    activate,
    deactivate,

    pub const json_field_names = .{
        .activate = "ACTIVATE",
        .deactivate = "DEACTIVATE",
    };
};
