pub const Approval = enum {
    approve,
    decline,

    pub const json_field_names = .{
        .approve = "APPROVE",
        .decline = "DECLINE",
    };
};
