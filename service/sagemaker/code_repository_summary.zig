const GitConfig = @import("git_config.zig").GitConfig;

/// Specifies summary information about a Git repository.
pub const CodeRepositorySummary = struct {
    /// The Amazon Resource Name (ARN) of the Git repository.
    code_repository_arn: []const u8,

    /// The name of the Git repository.
    code_repository_name: []const u8,

    /// The date and time that the Git repository was created.
    creation_time: i64,

    /// Configuration details for the Git repository, including the URL where it is
    /// located and the ARN of the Amazon Web Services Secrets Manager secret that
    /// contains the credentials used to access the repository.
    git_config: ?GitConfig,

    /// The date and time that the Git repository was last modified.
    last_modified_time: i64,

    pub const json_field_names = .{
        .code_repository_arn = "CodeRepositoryArn",
        .code_repository_name = "CodeRepositoryName",
        .creation_time = "CreationTime",
        .git_config = "GitConfig",
        .last_modified_time = "LastModifiedTime",
    };
};
