/// A resource policy grants one or more Amazon Web Services services and
/// accounts permissions
/// to access X-Ray. Each resource policy is associated with a
/// specific Amazon Web Services account.
pub const ResourcePolicy = struct {
    /// When the policy was last updated, in Unix time seconds.
    last_updated_time: ?i64,

    /// The resource policy document, which can be up to 5kb in size.
    policy_document: ?[]const u8,

    /// The name of the resource policy. Must be unique within a specific Amazon Web
    /// Services account.
    policy_name: ?[]const u8,

    /// Returns the current policy revision id for this policy name.
    policy_revision_id: ?[]const u8,

    pub const json_field_names = .{
        .last_updated_time = "LastUpdatedTime",
        .policy_document = "PolicyDocument",
        .policy_name = "PolicyName",
        .policy_revision_id = "PolicyRevisionId",
    };
};
