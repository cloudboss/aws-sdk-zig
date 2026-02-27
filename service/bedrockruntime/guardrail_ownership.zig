pub const GuardrailOwnership = enum {
    self,
    cross_account,

    pub const json_field_names = .{
        .self = "SELF",
        .cross_account = "CROSS_ACCOUNT",
    };
};
