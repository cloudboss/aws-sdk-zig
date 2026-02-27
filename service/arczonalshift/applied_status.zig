pub const AppliedStatus = enum {
    applied,
    not_applied,

    pub const json_field_names = .{
        .applied = "APPLIED",
        .not_applied = "NOT_APPLIED",
    };
};
