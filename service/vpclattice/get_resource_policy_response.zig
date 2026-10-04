pub const GetResourcePolicyResponse = struct {
    /// An IAM policy.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "policy",
    };
};
