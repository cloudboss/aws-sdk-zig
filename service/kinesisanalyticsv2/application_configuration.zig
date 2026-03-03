const ApplicationCodeConfiguration = @import("application_code_configuration.zig").ApplicationCodeConfiguration;
const ApplicationEncryptionConfiguration = @import("application_encryption_configuration.zig").ApplicationEncryptionConfiguration;
const ApplicationSnapshotConfiguration = @import("application_snapshot_configuration.zig").ApplicationSnapshotConfiguration;
const ApplicationSystemRollbackConfiguration = @import("application_system_rollback_configuration.zig").ApplicationSystemRollbackConfiguration;
const EnvironmentProperties = @import("environment_properties.zig").EnvironmentProperties;
const FlinkApplicationConfiguration = @import("flink_application_configuration.zig").FlinkApplicationConfiguration;
const SqlApplicationConfiguration = @import("sql_application_configuration.zig").SqlApplicationConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;
const ZeppelinApplicationConfiguration = @import("zeppelin_application_configuration.zig").ZeppelinApplicationConfiguration;

/// Specifies the creation parameters for a Managed Service for Apache Flink
/// application.
pub const ApplicationConfiguration = struct {
    /// The code location and type parameters for a Managed Service for Apache Flink
    /// application.
    application_code_configuration: ?ApplicationCodeConfiguration = null,

    /// The configuration to manage encryption at rest.
    application_encryption_configuration: ?ApplicationEncryptionConfiguration = null,

    /// Describes whether snapshots are enabled for a Managed Service for Apache
    /// Flink application.
    application_snapshot_configuration: ?ApplicationSnapshotConfiguration = null,

    /// Describes whether system rollbacks are enabled for a Managed Service for
    /// Apache Flink application.
    application_system_rollback_configuration: ?ApplicationSystemRollbackConfiguration = null,

    /// Describes execution properties for a Managed Service for Apache Flink
    /// application.
    environment_properties: ?EnvironmentProperties = null,

    /// The creation and update parameters for a Managed Service for Apache Flink
    /// application.
    flink_application_configuration: ?FlinkApplicationConfiguration = null,

    /// The creation and update parameters for a SQL-based Kinesis Data Analytics
    /// application.
    sql_application_configuration: ?SqlApplicationConfiguration = null,

    /// The array of descriptions of VPC configurations available to the
    /// application.
    vpc_configurations: ?[]const VpcConfiguration = null,

    /// The configuration parameters for a Managed Service for Apache Flink Studio
    /// notebook.
    zeppelin_application_configuration: ?ZeppelinApplicationConfiguration = null,

    pub const json_field_names = .{
        .application_code_configuration = "ApplicationCodeConfiguration",
        .application_encryption_configuration = "ApplicationEncryptionConfiguration",
        .application_snapshot_configuration = "ApplicationSnapshotConfiguration",
        .application_system_rollback_configuration = "ApplicationSystemRollbackConfiguration",
        .environment_properties = "EnvironmentProperties",
        .flink_application_configuration = "FlinkApplicationConfiguration",
        .sql_application_configuration = "SqlApplicationConfiguration",
        .vpc_configurations = "VpcConfigurations",
        .zeppelin_application_configuration = "ZeppelinApplicationConfiguration",
    };
};
