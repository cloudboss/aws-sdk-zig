const DisasterRecoveryType = @import("disaster_recovery_type.zig").DisasterRecoveryType;

/// The disaster recovery configuration for an Autonomous Database.
pub const DisasterRecoveryConfiguration = struct {
    /// The type of disaster recovery configured for the Autonomous Database.
    disaster_recovery_type: ?DisasterRecoveryType = null,

    /// Indicates whether automatic backups are replicated to the disaster recovery
    /// database.
    is_replicate_automatic_backups: ?bool = null,

    /// Indicates whether the standby database is a snapshot standby.
    is_snapshot_standby: ?bool = null,

    /// The date and time until which the snapshot standby database remains enabled.
    time_snapshot_standby_enabled_till: ?i64 = null,

    pub const json_field_names = .{
        .disaster_recovery_type = "disasterRecoveryType",
        .is_replicate_automatic_backups = "isReplicateAutomaticBackups",
        .is_snapshot_standby = "isSnapshotStandby",
        .time_snapshot_standby_enabled_till = "timeSnapshotStandbyEnabledTill",
    };
};
