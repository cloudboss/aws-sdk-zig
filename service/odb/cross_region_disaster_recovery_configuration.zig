const DisasterRecoveryType = @import("disaster_recovery_type.zig").DisasterRecoveryType;

/// The configuration for creating an Autonomous Database as a cross-Region
/// disaster recovery peer.
pub const CrossRegionDisasterRecoveryConfiguration = struct {
    /// Indicates whether automatic backups are replicated to the disaster recovery
    /// database.
    is_replicate_automatic_backups: ?bool = null,

    /// The type of remote disaster recovery to configure, either Autonomous Data
    /// Guard or backup-based.
    remote_disaster_recovery_type: DisasterRecoveryType,

    /// The Amazon Resource Name (ARN) of the source Autonomous Database for the
    /// cross-Region disaster recovery configuration.
    source_autonomous_database_arn: []const u8,

    pub const json_field_names = .{
        .is_replicate_automatic_backups = "isReplicateAutomaticBackups",
        .remote_disaster_recovery_type = "remoteDisasterRecoveryType",
        .source_autonomous_database_arn = "sourceAutonomousDatabaseArn",
    };
};
