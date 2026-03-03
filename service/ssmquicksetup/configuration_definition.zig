const aws = @import("aws");

/// The definition of a Quick Setup configuration.
pub const ConfigurationDefinition = struct {
    /// The ID of the configuration definition.
    id: ?[]const u8 = null,

    /// The ARN of the IAM role used to administrate local configuration
    /// deployments.
    local_deployment_administration_role_arn: ?[]const u8 = null,

    /// The name of the IAM role used to deploy local
    /// configurations.
    local_deployment_execution_role_name: ?[]const u8 = null,

    /// A list of key-value pairs containing the required parameters for the
    /// configuration
    /// type.
    parameters: []const aws.map.StringMapEntry,

    /// The type of the Quick Setup configuration.
    @"type": []const u8,

    /// The version of the Quick Setup type used.
    type_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .local_deployment_administration_role_arn = "LocalDeploymentAdministrationRoleArn",
        .local_deployment_execution_role_name = "LocalDeploymentExecutionRoleName",
        .parameters = "Parameters",
        .@"type" = "Type",
        .type_version = "TypeVersion",
    };
};
