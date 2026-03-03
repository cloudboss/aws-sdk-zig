/// Specifies configuration details for a Git repository when the repository is
/// updated.
pub const GitConfigForUpdate = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services Secrets Manager
    /// secret that contains the credentials used to access the git repository. The
    /// secret must have a staging label of `AWSCURRENT` and must be in the
    /// following format:
    ///
    /// `{"username": *UserName*, "password": *Password*}`
    secret_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .secret_arn = "SecretArn",
    };
};
