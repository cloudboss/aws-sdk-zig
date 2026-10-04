const CloneToRefreshableConfiguration = @import("clone_to_refreshable_configuration.zig").CloneToRefreshableConfiguration;
const CrossRegionDataGuardConfiguration = @import("cross_region_data_guard_configuration.zig").CrossRegionDataGuardConfiguration;
const CrossRegionDisasterRecoveryConfiguration = @import("cross_region_disaster_recovery_configuration.zig").CrossRegionDisasterRecoveryConfiguration;
const DatabaseCloneConfiguration = @import("database_clone_configuration.zig").DatabaseCloneConfiguration;
const PointInTimeRestoreConfiguration = @import("point_in_time_restore_configuration.zig").PointInTimeRestoreConfiguration;
const RestoreFromBackupConfiguration = @import("restore_from_backup_configuration.zig").RestoreFromBackupConfiguration;

/// The configuration details for the source used to create an Autonomous
/// Database. This is a union, so only one of the following members can be
/// specified.
pub const SourceConfiguration = union(enum) {
    /// The configuration for creating the Autonomous Database as a refreshable
    /// clone.
    clone_to_refreshable: ?CloneToRefreshableConfiguration,
    /// The configuration for creating the Autonomous Database as a cross-Region
    /// Oracle Data Guard peer.
    cross_region_data_guard: ?CrossRegionDataGuardConfiguration,
    /// The configuration for creating the Autonomous Database as a cross-Region
    /// disaster recovery peer.
    cross_region_disaster_recovery: ?CrossRegionDisasterRecoveryConfiguration,
    /// The configuration for creating the Autonomous Database as a clone of an
    /// existing database.
    database_clone: ?DatabaseCloneConfiguration,
    /// The configuration for creating the Autonomous Database by restoring to a
    /// point in time.
    point_in_time_restore: ?PointInTimeRestoreConfiguration,
    /// The configuration for creating the Autonomous Database by restoring from a
    /// backup.
    restore_from_backup: ?RestoreFromBackupConfiguration,

    pub const json_field_names = .{
        .clone_to_refreshable = "cloneToRefreshable",
        .cross_region_data_guard = "crossRegionDataGuard",
        .cross_region_disaster_recovery = "crossRegionDisasterRecovery",
        .database_clone = "databaseClone",
        .point_in_time_restore = "pointInTimeRestore",
        .restore_from_backup = "restoreFromBackup",
    };
};
