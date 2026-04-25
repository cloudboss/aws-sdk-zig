/// The repository credentials for private registry authentication.
pub const RepositoryCredentials = struct {
    /// The Amazon Resource Name (ARN) of the secret containing the private
    /// repository credentials.
    ///
    /// When you use the Amazon ECS API, CLI, or Amazon Web Services SDK, if the
    /// secret exists in the same Region as the task that you're launching then you
    /// can use either the full ARN or the name of the secret. When you use the
    /// Amazon Web Services Management Console, you must specify the full ARN of the
    /// secret.
    credentials_parameter: []const u8,

    pub const json_field_names = .{
        .credentials_parameter = "credentialsParameter",
    };
};
