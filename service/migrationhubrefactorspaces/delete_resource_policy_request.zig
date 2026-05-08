pub const DeleteResourcePolicyRequest = struct {
    /// Amazon Resource Name (ARN) of the resource associated with the policy.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
