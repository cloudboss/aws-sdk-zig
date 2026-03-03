/// The private repository authentication credentials to use.
pub const AwsEcsTaskDefinitionContainerDefinitionsRepositoryCredentialsDetails = struct {
    /// The ARN of the secret that contains the private repository credentials.
    credentials_parameter: ?[]const u8 = null,

    pub const json_field_names = .{
        .credentials_parameter = "CredentialsParameter",
    };
};
