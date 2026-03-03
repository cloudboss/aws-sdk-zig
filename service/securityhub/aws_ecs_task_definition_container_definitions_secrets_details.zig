/// A secret to pass to the container.
pub const AwsEcsTaskDefinitionContainerDefinitionsSecretsDetails = struct {
    /// The name of the secret.
    name: ?[]const u8 = null,

    /// The secret to expose to the container. The value is either the full ARN of
    /// the Secrets Manager
    /// secret or the full ARN of the parameter in the Systems Manager Parameter
    /// Store.
    value_from: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value_from = "ValueFrom",
    };
};
