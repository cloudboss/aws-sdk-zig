/// Specifies configuration details for a Git repository in your Amazon Web
/// Services account.
pub const GitConfig = struct {
    /// The default branch for the Git repository.
    branch: ?[]const u8 = null,

    /// The URL where the Git repository is located.
    repository_url: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the credentials used to access the git repository. The
    /// secret must have a staging label of `AWSCURRENT` and must be in the
    /// following format:
    ///
    /// `{"username": *UserName*, "password": *Password*}`
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .branch = "Branch",
        .repository_url = "RepositoryUrl",
        .secret_arn = "SecretArn",
    };
};
