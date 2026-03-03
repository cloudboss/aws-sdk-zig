const CatalogConfigurationDescription = @import("catalog_configuration_description.zig").CatalogConfigurationDescription;
const CustomArtifactConfigurationDescription = @import("custom_artifact_configuration_description.zig").CustomArtifactConfigurationDescription;
const DeployAsApplicationConfigurationDescription = @import("deploy_as_application_configuration_description.zig").DeployAsApplicationConfigurationDescription;
const ZeppelinMonitoringConfigurationDescription = @import("zeppelin_monitoring_configuration_description.zig").ZeppelinMonitoringConfigurationDescription;

/// The configuration of a Managed Service for Apache Flink Studio notebook.
pub const ZeppelinApplicationConfigurationDescription = struct {
    /// The Amazon Glue Data Catalog that is associated with the Managed Service for
    /// Apache Flink Studio notebook.
    catalog_configuration_description: ?CatalogConfigurationDescription = null,

    /// Custom artifacts are dependency JARs and user-defined functions (UDF).
    custom_artifacts_configuration_description: ?[]const CustomArtifactConfigurationDescription = null,

    /// The parameters required to deploy a Managed Service for Apache Flink Studio
    /// notebook as an application with durable state.
    deploy_as_application_configuration_description: ?DeployAsApplicationConfigurationDescription = null,

    /// The monitoring configuration of a Managed Service for Apache Flink Studio
    /// notebook.
    monitoring_configuration_description: ZeppelinMonitoringConfigurationDescription,

    pub const json_field_names = .{
        .catalog_configuration_description = "CatalogConfigurationDescription",
        .custom_artifacts_configuration_description = "CustomArtifactsConfigurationDescription",
        .deploy_as_application_configuration_description = "DeployAsApplicationConfigurationDescription",
        .monitoring_configuration_description = "MonitoringConfigurationDescription",
    };
};
