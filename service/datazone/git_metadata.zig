/// The Git metadata for a notebook sync operation in Amazon SageMaker Unified
/// Studio. Contains information about the Git repository, branch, and commit
/// associated with the notebook.
pub const GitMetadata = struct {
    /// The name of the Git branch.
    branch: []const u8,

    /// The commit hash in the Git repository.
    commit_hash: []const u8,

    /// The commit message associated with the Git commit.
    commit_message: ?[]const u8 = null,

    /// The timestamp of when the commit was made.
    committed_at: ?i64 = null,

    /// The identifier of the Git connection.
    connection_id: []const u8,

    /// The name of the file in the Git repository.
    file_name: ?[]const u8 = null,

    /// The name of the Git repository.
    repository: []const u8,

    pub const json_field_names = .{
        .branch = "branch",
        .commit_hash = "commitHash",
        .commit_message = "commitMessage",
        .committed_at = "committedAt",
        .connection_id = "connectionId",
        .file_name = "fileName",
        .repository = "repository",
    };
};
