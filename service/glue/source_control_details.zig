const SourceControlAuthStrategy = @import("source_control_auth_strategy.zig").SourceControlAuthStrategy;
const SourceControlProvider = @import("source_control_provider.zig").SourceControlProvider;

/// The details for a source control configuration for a job, allowing
/// synchronization of job artifacts to or from a remote repository.
pub const SourceControlDetails = struct {
    /// The type of authentication, which can be an authentication token stored in
    /// Amazon Web Services Secrets Manager, or a personal access token.
    auth_strategy: ?SourceControlAuthStrategy,

    /// The value of an authorization token.
    auth_token: ?[]const u8,

    /// An optional branch in the remote repository.
    branch: ?[]const u8,

    /// An optional folder in the remote repository.
    folder: ?[]const u8,

    /// The last commit ID for a commit in the remote repository.
    last_commit_id: ?[]const u8,

    /// The owner of the remote repository that contains the job artifacts.
    owner: ?[]const u8,

    /// The provider for the remote repository.
    provider: ?SourceControlProvider,

    /// The name of the remote repository that contains the job artifacts.
    repository: ?[]const u8,

    pub const json_field_names = .{
        .auth_strategy = "AuthStrategy",
        .auth_token = "AuthToken",
        .branch = "Branch",
        .folder = "Folder",
        .last_commit_id = "LastCommitId",
        .owner = "Owner",
        .provider = "Provider",
        .repository = "Repository",
    };
};
