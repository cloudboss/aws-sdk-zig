const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The properties of a Git connection returned by get and list operations,
/// including connection status and any error details.
pub const GitPropertiesOutput = struct {
    /// The ARN of the CodeConnections connection used to connect to the Git
    /// repository.
    code_connection_arn: []const u8,

    /// The default branch of the Git repository.
    default_branch: []const u8,

    /// The error message that describes why the Git connection failed. This member
    /// is populated when the connection status is CREATE_FAILED or UPDATE_FAILED.
    error_message: ?[]const u8 = null,

    /// The ID of the Git repository. This is the owner and repository name, for
    /// example, owner/repo-name.
    repository_id: []const u8,

    /// The status of the Git connection.
    status: ?ConnectionStatus = null,

    pub const json_field_names = .{
        .code_connection_arn = "codeConnectionArn",
        .default_branch = "defaultBranch",
        .error_message = "errorMessage",
        .repository_id = "repositoryId",
        .status = "status",
    };
};
