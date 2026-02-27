pub const RetentionLockType = enum {
    compliance,
    governance,
    none,

    pub const json_field_names = .{
        .compliance = "COMPLIANCE",
        .governance = "GOVERNANCE",
        .none = "NONE",
    };
};
