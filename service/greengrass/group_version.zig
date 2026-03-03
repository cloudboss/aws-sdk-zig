/// Information about a group version.
pub const GroupVersion = struct {
    /// The ARN of the connector definition version for this group.
    connector_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the core definition version for this group.
    core_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the device definition version for this group.
    device_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the function definition version for this group.
    function_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the logger definition version for this group.
    logger_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the resource definition version for this group.
    resource_definition_version_arn: ?[]const u8 = null,

    /// The ARN of the subscription definition version for this group.
    subscription_definition_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_definition_version_arn = "ConnectorDefinitionVersionArn",
        .core_definition_version_arn = "CoreDefinitionVersionArn",
        .device_definition_version_arn = "DeviceDefinitionVersionArn",
        .function_definition_version_arn = "FunctionDefinitionVersionArn",
        .logger_definition_version_arn = "LoggerDefinitionVersionArn",
        .resource_definition_version_arn = "ResourceDefinitionVersionArn",
        .subscription_definition_version_arn = "SubscriptionDefinitionVersionArn",
    };
};
