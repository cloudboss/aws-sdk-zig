const ApplicationCodeConfigurationUpdate = @import("application_code_configuration_update.zig").ApplicationCodeConfigurationUpdate;
const ApplicationEncryptionConfigurationUpdate = @import("application_encryption_configuration_update.zig").ApplicationEncryptionConfigurationUpdate;
const ApplicationSnapshotConfigurationUpdate = @import("application_snapshot_configuration_update.zig").ApplicationSnapshotConfigurationUpdate;
const ApplicationSystemRollbackConfigurationUpdate = @import("application_system_rollback_configuration_update.zig").ApplicationSystemRollbackConfigurationUpdate;
const EnvironmentPropertyUpdates = @import("environment_property_updates.zig").EnvironmentPropertyUpdates;
const FlinkApplicationConfigurationUpdate = @import("flink_application_configuration_update.zig").FlinkApplicationConfigurationUpdate;
const SqlApplicationConfigurationUpdate = @import("sql_application_configuration_update.zig").SqlApplicationConfigurationUpdate;
const VpcConfigurationUpdate = @import("vpc_configuration_update.zig").VpcConfigurationUpdate;
const ZeppelinApplicationConfigurationUpdate = @import("zeppelin_application_configuration_update.zig").ZeppelinApplicationConfigurationUpdate;

/// Describes updates to an application's configuration.
pub const ApplicationConfigurationUpdate = struct {
    /// Describes updates to an application's code
    /// configuration.
    application_code_configuration_update: ?ApplicationCodeConfigurationUpdate = null,

    /// Represents an update for encryption at rest configuration.
    application_encryption_configuration_update: ?ApplicationEncryptionConfigurationUpdate = null,

    /// Describes whether snapshots are enabled for a Managed Service for Apache
    /// Flink application.
    application_snapshot_configuration_update: ?ApplicationSnapshotConfigurationUpdate = null,

    /// Describes whether system rollbacks are enabled for a Managed Service for
    /// Apache Flink application.
    application_system_rollback_configuration_update: ?ApplicationSystemRollbackConfigurationUpdate = null,

    /// Describes updates to the environment properties for a Managed Service for
    /// Apache Flink application.
    environment_property_updates: ?EnvironmentPropertyUpdates = null,

    /// Describes updates to a Managed Service for Apache Flink application's
    /// configuration.
    flink_application_configuration_update: ?FlinkApplicationConfigurationUpdate = null,

    /// Describes updates to a SQL-based Kinesis Data Analytics application's
    /// configuration.
    sql_application_configuration_update: ?SqlApplicationConfigurationUpdate = null,

    /// Updates to the array of descriptions of VPC configurations available to the
    /// application.
    vpc_configuration_updates: ?[]const VpcConfigurationUpdate = null,

    /// Updates to the configuration of a Managed Service for Apache Flink Studio
    /// notebook.
    zeppelin_application_configuration_update: ?ZeppelinApplicationConfigurationUpdate = null,

    pub const json_field_names = .{
        .application_code_configuration_update = "ApplicationCodeConfigurationUpdate",
        .application_encryption_configuration_update = "ApplicationEncryptionConfigurationUpdate",
        .application_snapshot_configuration_update = "ApplicationSnapshotConfigurationUpdate",
        .application_system_rollback_configuration_update = "ApplicationSystemRollbackConfigurationUpdate",
        .environment_property_updates = "EnvironmentPropertyUpdates",
        .flink_application_configuration_update = "FlinkApplicationConfigurationUpdate",
        .sql_application_configuration_update = "SqlApplicationConfigurationUpdate",
        .vpc_configuration_updates = "VpcConfigurationUpdates",
        .zeppelin_application_configuration_update = "ZeppelinApplicationConfigurationUpdate",
    };
};
