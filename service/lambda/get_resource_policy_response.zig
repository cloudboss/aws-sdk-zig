pub const GetResourcePolicyResponse = struct {
    /// The resource-based policy attached to the Lambda resource you specified.
    policy: ?[]const u8 = null,

    /// The revision ID of the policy. Pass this value as the `RevisionId` in a
    /// PutResourcePolicy or DeleteResourcePolicy request. Doing so ensures the
    /// operation acts on the expected version of the policy.
    revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .policy = "Policy",
        .revision_id = "RevisionId",
    };
};
