pub const ChangeRequestAction = enum {
    approve,
    deny,
    cancel,
    commit,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .deny = "DENY",
        .cancel = "CANCEL",
        .commit = "COMMIT",
    };
};
