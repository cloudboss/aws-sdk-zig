/// The repository credentials for private registry authentication to pass to
/// the container.
pub const ExpressGatewayRepositoryCredentials = struct {
    /// The Amazon Resource Name (ARN) of the secret containing the private
    /// repository credentials.
    credentials_parameter: ?[]const u8 = null,

    pub const json_field_names = .{
        .credentials_parameter = "credentialsParameter",
    };
};
