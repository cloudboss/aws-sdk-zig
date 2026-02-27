pub const GuardrailContentPolicyAction = enum {
    blocked,
    none,

    pub const json_field_names = .{
        .blocked = "BLOCKED",
        .none = "NONE",
    };
};
