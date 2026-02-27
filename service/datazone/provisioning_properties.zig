const CloudFormationProperties = @import("cloud_formation_properties.zig").CloudFormationProperties;

/// The provisioning properties of an environment blueprint.
pub const ProvisioningProperties = union(enum) {
    /// The cloud formation properties included as part of the provisioning
    /// properties of an environment blueprint.
    cloud_formation: ?CloudFormationProperties,

    pub const json_field_names = .{
        .cloud_formation = "cloudFormation",
    };
};
