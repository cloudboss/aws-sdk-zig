const ApplicationEncryptionConfigurationDescription = @import("application_encryption_configuration_description.zig").ApplicationEncryptionConfigurationDescription;
const RuntimeEnvironment = @import("runtime_environment.zig").RuntimeEnvironment;
const SnapshotStatus = @import("snapshot_status.zig").SnapshotStatus;

/// Provides details about a snapshot of application state.
pub const SnapshotDetails = struct {
    /// Specifies the encryption settings of data at rest for the application
    /// snapshot.
    application_encryption_configuration_description: ?ApplicationEncryptionConfigurationDescription,

    /// The current application version ID when the snapshot was created.
    application_version_id: i64,

    /// The Flink Runtime for the application snapshot.
    runtime_environment: ?RuntimeEnvironment,

    /// The timestamp of the application snapshot.
    snapshot_creation_timestamp: ?i64,

    /// The identifier for the application snapshot.
    snapshot_name: []const u8,

    /// The status of the application snapshot.
    snapshot_status: SnapshotStatus,

    pub const json_field_names = .{
        .application_encryption_configuration_description = "ApplicationEncryptionConfigurationDescription",
        .application_version_id = "ApplicationVersionId",
        .runtime_environment = "RuntimeEnvironment",
        .snapshot_creation_timestamp = "SnapshotCreationTimestamp",
        .snapshot_name = "SnapshotName",
        .snapshot_status = "SnapshotStatus",
    };
};
