const RequirementLevel = @import("requirement_level.zig").RequirementLevel;

/// The configuration parameters for a package.
pub const PackageConfiguration = struct {
    /// The configuration requirements for the package.
    configuration_requirement: RequirementLevel,

    /// The relative file path for the license associated with the package.
    license_filepath: ?[]const u8 = null,

    /// The license requirements for the package.
    license_requirement: RequirementLevel,

    /// This indicates whether a B/G deployment is required for updating the
    /// configuration
    /// that the plugin is prerequisite for.
    requires_restart_for_configuration_update: ?bool = null,

    pub const json_field_names = .{
        .configuration_requirement = "ConfigurationRequirement",
        .license_filepath = "LicenseFilepath",
        .license_requirement = "LicenseRequirement",
        .requires_restart_for_configuration_update = "RequiresRestartForConfigurationUpdate",
    };
};
