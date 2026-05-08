pub const GetResourcePolicyResponse = struct {
    /// The resource policy document.
    policy_document: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy_document = "PolicyDocument",
    };
};
