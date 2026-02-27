/// The repository credentials for private registry authentication.
pub const RepositoryCredentials = struct {
    /// The Amazon Resource Name (ARN) of the secret containing the private
    /// repository
    /// credentials.
    credentials_parameter: []const u8,

    pub const json_field_names = .{
        .credentials_parameter = "credentialsParameter",
    };
};
