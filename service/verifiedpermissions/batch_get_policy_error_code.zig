pub const BatchGetPolicyErrorCode = enum {
    policy_store_not_found,
    policy_not_found,

    pub const json_field_names = .{
        .policy_store_not_found = "POLICY_STORE_NOT_FOUND",
        .policy_not_found = "POLICY_NOT_FOUND",
    };
};
