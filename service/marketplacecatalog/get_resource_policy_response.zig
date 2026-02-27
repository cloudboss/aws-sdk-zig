pub const GetResourcePolicyResponse = struct {
    /// The policy document to set; formatted in JSON.
    policy: ?[]const u8,

    pub const json_field_names = .{
        .policy = "Policy",
    };
};
