const RdsRequirements = @import("rds_requirements.zig").RdsRequirements;
const RdsConfiguration = @import("rds_configuration.zig").RdsConfiguration;

/// Provides information that describes a recommendation of a target engine on
/// Amazon RDS.
pub const RdsRecommendation = struct {
    /// Supplemental information about the requirements to the recommended target
    /// database on
    /// Amazon RDS.
    requirements_to_target: ?RdsRequirements = null,

    /// Supplemental information about the configuration of the recommended target
    /// database on
    /// Amazon RDS.
    target_configuration: ?RdsConfiguration = null,

    pub const json_field_names = .{
        .requirements_to_target = "RequirementsToTarget",
        .target_configuration = "TargetConfiguration",
    };
};
