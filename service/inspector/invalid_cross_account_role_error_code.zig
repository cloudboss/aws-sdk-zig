pub const InvalidCrossAccountRoleErrorCode = enum {
    role_does_not_exist_or_invalid_trust_relationship,
    role_does_not_have_correct_policy,

    pub const json_field_names = .{
        .role_does_not_exist_or_invalid_trust_relationship = "ROLE_DOES_NOT_EXIST_OR_INVALID_TRUST_RELATIONSHIP",
        .role_does_not_have_correct_policy = "ROLE_DOES_NOT_HAVE_CORRECT_POLICY",
    };
};
