const aws = @import("aws");

const ProvisioningConfiguration = @import("provisioning_configuration.zig").ProvisioningConfiguration;

/// The configuration details of an environment blueprint.
pub const EnvironmentBlueprintConfigurationItem = struct {
    /// The timestamp of when an environment blueprint was created.
    created_at: ?i64,

    /// The identifier of the Amazon DataZone domain in which an environment
    /// blueprint exists.
    domain_id: []const u8,

    /// The enabled Amazon Web Services Regions specified in a blueprint
    /// configuration.
    enabled_regions: ?[]const []const u8,

    /// The identifier of the environment blueprint.
    environment_blueprint_id: []const u8,

    /// The environment role permission boundary.
    environment_role_permission_boundary: ?[]const u8,

    /// The ARN of the manage access role specified in the environment blueprint
    /// configuration.
    manage_access_role_arn: ?[]const u8,

    /// The provisioning configuration of a blueprint.
    provisioning_configurations: ?[]const ProvisioningConfiguration,

    /// The ARN of the provisioning role specified in the environment blueprint
    /// configuration.
    provisioning_role_arn: ?[]const u8,

    /// The regional parameters of the environment blueprint.
    regional_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// The timestamp of when the environment blueprint was updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .domain_id = "domainId",
        .enabled_regions = "enabledRegions",
        .environment_blueprint_id = "environmentBlueprintId",
        .environment_role_permission_boundary = "environmentRolePermissionBoundary",
        .manage_access_role_arn = "manageAccessRoleArn",
        .provisioning_configurations = "provisioningConfigurations",
        .provisioning_role_arn = "provisioningRoleArn",
        .regional_parameters = "regionalParameters",
        .updated_at = "updatedAt",
    };
};
