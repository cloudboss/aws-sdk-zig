const LakeFormationConfiguration = @import("lake_formation_configuration.zig").LakeFormationConfiguration;

/// The provisioning configuration of the blueprint.
pub const ProvisioningConfiguration = union(enum) {
    /// The Lake Formation configuration of the Data Lake blueprint.
    lake_formation_configuration: ?LakeFormationConfiguration,

    pub const json_field_names = .{
        .lake_formation_configuration = "lakeFormationConfiguration",
    };
};
