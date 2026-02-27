const CatalogConfigurationUpdate = @import("catalog_configuration_update.zig").CatalogConfigurationUpdate;
const CustomArtifactConfiguration = @import("custom_artifact_configuration.zig").CustomArtifactConfiguration;
const DeployAsApplicationConfigurationUpdate = @import("deploy_as_application_configuration_update.zig").DeployAsApplicationConfigurationUpdate;
const ZeppelinMonitoringConfigurationUpdate = @import("zeppelin_monitoring_configuration_update.zig").ZeppelinMonitoringConfigurationUpdate;

/// Updates to the configuration of Managed Service for Apache Flink Studio
/// notebook.
pub const ZeppelinApplicationConfigurationUpdate = struct {
    /// Updates to the configuration of the Amazon Glue Data Catalog that is
    /// associated with the Managed Service for Apache Flink Studio notebook.
    catalog_configuration_update: ?CatalogConfigurationUpdate,

    /// Updates to the customer artifacts. Custom artifacts are dependency JAR files
    /// and user-defined functions (UDF).
    custom_artifacts_configuration_update: ?[]const CustomArtifactConfiguration,

    deploy_as_application_configuration_update: ?DeployAsApplicationConfigurationUpdate,

    /// Updates to the monitoring configuration of a Managed Service for Apache
    /// Flink Studio notebook.
    monitoring_configuration_update: ?ZeppelinMonitoringConfigurationUpdate,

    pub const json_field_names = .{
        .catalog_configuration_update = "CatalogConfigurationUpdate",
        .custom_artifacts_configuration_update = "CustomArtifactsConfigurationUpdate",
        .deploy_as_application_configuration_update = "DeployAsApplicationConfigurationUpdate",
        .monitoring_configuration_update = "MonitoringConfigurationUpdate",
    };
};
