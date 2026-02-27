/// A secret to pass to the log configuration.
pub const AwsEcsTaskDefinitionContainerDefinitionsLogConfigurationSecretOptionsDetails = struct {
    /// The name of the secret.
    name: ?[]const u8,

    /// The secret to expose to the container.
    ///
    /// The value is either the full ARN of the Secrets Manager secret or the full
    /// ARN of the
    /// parameter in the Systems Manager Parameter Store.
    value_from: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value_from = "ValueFrom",
    };
};
