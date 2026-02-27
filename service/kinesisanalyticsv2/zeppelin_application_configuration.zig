const CatalogConfiguration = @import("catalog_configuration.zig").CatalogConfiguration;
const CustomArtifactConfiguration = @import("custom_artifact_configuration.zig").CustomArtifactConfiguration;
const DeployAsApplicationConfiguration = @import("deploy_as_application_configuration.zig").DeployAsApplicationConfiguration;
const ZeppelinMonitoringConfiguration = @import("zeppelin_monitoring_configuration.zig").ZeppelinMonitoringConfiguration;

/// The configuration of a Managed Service for Apache Flink Studio notebook.
pub const ZeppelinApplicationConfiguration = struct {
    /// The Amazon Glue Data Catalog that you use in queries in a Managed Service
    /// for Apache Flink Studio notebook.
    catalog_configuration: ?CatalogConfiguration,

    /// Custom artifacts are dependency JARs and user-defined functions (UDF).
    custom_artifacts_configuration: ?[]const CustomArtifactConfiguration,

    /// The information required to deploy a Managed Service for Apache Flink Studio
    /// notebook as an application with durable state.
    deploy_as_application_configuration: ?DeployAsApplicationConfiguration,

    /// The monitoring configuration of a Managed Service for Apache Flink Studio
    /// notebook.
    monitoring_configuration: ?ZeppelinMonitoringConfiguration,

    pub const json_field_names = .{
        .catalog_configuration = "CatalogConfiguration",
        .custom_artifacts_configuration = "CustomArtifactsConfiguration",
        .deploy_as_application_configuration = "DeployAsApplicationConfiguration",
        .monitoring_configuration = "MonitoringConfiguration",
    };
};
