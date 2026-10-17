/// Configuration for GitLab project integration.
pub const GitLabConfiguration = struct {
    /// GitLab instance identifier (e.g., gitlab.com or
    /// e2e.gamma.dev.us-east-1.gitlab.falco.ai.aws.dev)
    instance_identifier: ?[]const u8 = null,

    /// GitLab numeric project ID.
    project_id: []const u8,

    /// Full GitLab project path (e.g., namespace/project-name).
    project_path: []const u8,

    /// The identifier of the release management association that this project maps
    /// to for automatic verification testing.
    release_management_association_id: ?[]const u8 = null,

    /// Optional role ARN that AIDevOps assumes at runtime for automatic
    /// verification testing and VPC connectivity on this association.
    runtime_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_identifier = "instanceIdentifier",
        .project_id = "projectId",
        .project_path = "projectPath",
        .release_management_association_id = "releaseManagementAssociationId",
        .runtime_role_arn = "runtimeRoleArn",
    };
};
