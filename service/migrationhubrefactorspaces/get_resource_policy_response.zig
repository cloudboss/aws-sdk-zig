pub const GetResourcePolicyResponse = struct {
    /// A JSON-formatted string for an Amazon Web Services resource-based policy.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};
