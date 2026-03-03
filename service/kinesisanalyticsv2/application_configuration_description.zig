const ApplicationCodeConfigurationDescription = @import("application_code_configuration_description.zig").ApplicationCodeConfigurationDescription;
const ApplicationEncryptionConfigurationDescription = @import("application_encryption_configuration_description.zig").ApplicationEncryptionConfigurationDescription;
const ApplicationSnapshotConfigurationDescription = @import("application_snapshot_configuration_description.zig").ApplicationSnapshotConfigurationDescription;
const ApplicationSystemRollbackConfigurationDescription = @import("application_system_rollback_configuration_description.zig").ApplicationSystemRollbackConfigurationDescription;
const EnvironmentPropertyDescriptions = @import("environment_property_descriptions.zig").EnvironmentPropertyDescriptions;
const FlinkApplicationConfigurationDescription = @import("flink_application_configuration_description.zig").FlinkApplicationConfigurationDescription;
const RunConfigurationDescription = @import("run_configuration_description.zig").RunConfigurationDescription;
const SqlApplicationConfigurationDescription = @import("sql_application_configuration_description.zig").SqlApplicationConfigurationDescription;
const VpcConfigurationDescription = @import("vpc_configuration_description.zig").VpcConfigurationDescription;
const ZeppelinApplicationConfigurationDescription = @import("zeppelin_application_configuration_description.zig").ZeppelinApplicationConfigurationDescription;

/// Describes details about the application code and starting parameters for a
/// Managed Service for Apache Flink application.
pub const ApplicationConfigurationDescription = struct {
    /// The details about the application code for a Managed Service for Apache
    /// Flink application.
    application_code_configuration_description: ?ApplicationCodeConfigurationDescription = null,

    /// Describes the encryption at rest configuration.
    application_encryption_configuration_description: ?ApplicationEncryptionConfigurationDescription = null,

    /// Describes whether snapshots are enabled for a Managed Service for Apache
    /// Flink application.
    application_snapshot_configuration_description: ?ApplicationSnapshotConfigurationDescription = null,

    /// Describes whether system rollbacks are enabled for a Managed Service for
    /// Apache Flink application.
    application_system_rollback_configuration_description: ?ApplicationSystemRollbackConfigurationDescription = null,

    /// Describes execution properties for a Managed Service for Apache Flink
    /// application.
    environment_property_descriptions: ?EnvironmentPropertyDescriptions = null,

    /// The details about a Managed Service for Apache Flink application.
    flink_application_configuration_description: ?FlinkApplicationConfigurationDescription = null,

    /// The details about the starting properties for a Managed Service for Apache
    /// Flink application.
    run_configuration_description: ?RunConfigurationDescription = null,

    /// The details about inputs, outputs, and reference data sources for a
    /// SQL-based Kinesis Data Analytics application.
    sql_application_configuration_description: ?SqlApplicationConfigurationDescription = null,

    /// The array of descriptions of VPC configurations available to the
    /// application.
    vpc_configuration_descriptions: ?[]const VpcConfigurationDescription = null,

    /// The configuration parameters for a Managed Service for Apache Flink Studio
    /// notebook.
    zeppelin_application_configuration_description: ?ZeppelinApplicationConfigurationDescription = null,

    pub const json_field_names = .{
        .application_code_configuration_description = "ApplicationCodeConfigurationDescription",
        .application_encryption_configuration_description = "ApplicationEncryptionConfigurationDescription",
        .application_snapshot_configuration_description = "ApplicationSnapshotConfigurationDescription",
        .application_system_rollback_configuration_description = "ApplicationSystemRollbackConfigurationDescription",
        .environment_property_descriptions = "EnvironmentPropertyDescriptions",
        .flink_application_configuration_description = "FlinkApplicationConfigurationDescription",
        .run_configuration_description = "RunConfigurationDescription",
        .sql_application_configuration_description = "SqlApplicationConfigurationDescription",
        .vpc_configuration_descriptions = "VpcConfigurationDescriptions",
        .zeppelin_application_configuration_description = "ZeppelinApplicationConfigurationDescription",
    };
};
