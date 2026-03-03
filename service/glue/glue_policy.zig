/// A structure for returning a resource policy.
pub const GluePolicy = struct {
    /// The date and time at which the policy was created.
    create_time: ?i64 = null,

    /// Contains the hash value associated with this policy.
    policy_hash: ?[]const u8 = null,

    /// Contains the requested policy document, in JSON format.
    policy_in_json: ?[]const u8 = null,

    /// The date and time at which the policy was last updated.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .policy_hash = "PolicyHash",
        .policy_in_json = "PolicyInJson",
        .update_time = "UpdateTime",
    };
};
