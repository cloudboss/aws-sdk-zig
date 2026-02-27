pub const ApprovalState = enum {
    approve,
    revoke,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .revoke = "REVOKE",
    };
};
