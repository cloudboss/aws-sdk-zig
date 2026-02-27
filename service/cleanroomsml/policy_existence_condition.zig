pub const PolicyExistenceCondition = enum {
    policy_must_exist,
    policy_must_not_exist,

    pub const json_field_names = .{
        .policy_must_exist = "POLICY_MUST_EXIST",
        .policy_must_not_exist = "POLICY_MUST_NOT_EXIST",
    };
};
