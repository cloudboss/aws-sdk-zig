pub const GetResourcePolicyResponse = struct {
    /// The policy attached to a resource.
    policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};
