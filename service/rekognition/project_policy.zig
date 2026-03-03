/// Describes a project policy in the response from ListProjectPolicies.
pub const ProjectPolicy = struct {
    /// The Unix datetime for the creation of the project policy.
    creation_timestamp: ?i64 = null,

    /// The Unix datetime for when the project policy was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The JSON document for the project policy.
    policy_document: ?[]const u8 = null,

    /// The name of the project policy.
    policy_name: ?[]const u8 = null,

    /// The revision ID of the project policy.
    policy_revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the project to which the project policy is
    /// attached.
    project_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_timestamp = "CreationTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .policy_document = "PolicyDocument",
        .policy_name = "PolicyName",
        .policy_revision_id = "PolicyRevisionId",
        .project_arn = "ProjectArn",
    };
};
