const aws = @import("aws");

const ProvisioningConfiguration = @import("provisioning_configuration.zig").ProvisioningConfiguration;
const ResourceConfiguration = @import("resource_configuration.zig").ResourceConfiguration;

/// The configuration details of an environment blueprint.
pub const EnvironmentBlueprintConfigurationItem = struct {
    /// Specifies whether user-provided resource configurations are allowed for the
    /// environment blueprint.
    allow_user_provided_configurations: ?bool = null,

    /// The timestamp of when an environment blueprint was created.
    created_at: ?i64 = null,

    /// The identifier of the Amazon DataZone domain in which an environment
    /// blueprint exists.
    domain_id: []const u8,

    /// The enabled Amazon Web Services Regions specified in a blueprint
    /// configuration.
    enabled_regions: ?[]const []const u8 = null,

    /// The identifier of the environment blueprint.
    environment_blueprint_id: []const u8,

    /// The environment role permission boundary.
    environment_role_permission_boundary: ?[]const u8 = null,

    /// The ARN of the manage access role specified in the environment blueprint
    /// configuration.
    manage_access_role_arn: ?[]const u8 = null,

    /// The provisioning configuration of a blueprint.
    provisioning_configurations: ?[]const ProvisioningConfiguration = null,

    /// The ARN of the provisioning role specified in the environment blueprint
    /// configuration.
    provisioning_role_arn: ?[]const u8 = null,

    /// The regional parameters of the environment blueprint.
    regional_parameters: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    /// The resource configurations of the environment blueprint.
    resource_configurations: ?[]const ResourceConfiguration = null,

    /// The timestamp of when the environment blueprint was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .allow_user_provided_configurations = "allowUserProvidedConfigurations",
        .created_at = "createdAt",
        .domain_id = "domainId",
        .enabled_regions = "enabledRegions",
        .environment_blueprint_id = "environmentBlueprintId",
        .environment_role_permission_boundary = "environmentRolePermissionBoundary",
        .manage_access_role_arn = "manageAccessRoleArn",
        .provisioning_configurations = "provisioningConfigurations",
        .provisioning_role_arn = "provisioningRoleArn",
        .regional_parameters = "regionalParameters",
        .resource_configurations = "resourceConfigurations",
        .updated_at = "updatedAt",
    };
};
