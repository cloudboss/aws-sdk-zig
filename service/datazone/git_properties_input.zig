/// Contains the Git connection properties that you specify when creating a Git
/// connection.
pub const GitPropertiesInput = struct {
    /// The ARN of the CodeConnections connection used to connect to the Git
    /// repository.
    code_connection_arn: []const u8,

    /// The default branch of the Git repository.
    default_branch: []const u8,

    /// The ID of the Git repository. This is the owner and repository name, for
    /// example, owner/repo-name.
    repository_id: []const u8,

    pub const json_field_names = .{
        .code_connection_arn = "codeConnectionArn",
        .default_branch = "defaultBranch",
        .repository_id = "repositoryId",
    };
};
