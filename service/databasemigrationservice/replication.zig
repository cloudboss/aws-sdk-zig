const PremigrationAssessmentStatus = @import("premigration_assessment_status.zig").PremigrationAssessmentStatus;
const ProvisionData = @import("provision_data.zig").ProvisionData;
const ReplicationStats = @import("replication_stats.zig").ReplicationStats;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;

/// Provides information that describes a serverless replication created by the
/// `CreateReplication` operation.
pub const Replication = struct {
    /// Indicates the start time for a change data capture (CDC) operation. Use
    /// either
    /// `CdcStartTime` or `CdcStartPosition` to specify when you want a
    /// CDC operation to start. Specifying both values results in an error.
    cdc_start_position: ?[]const u8,

    /// Indicates the start time for a change data capture (CDC) operation. Use
    /// either
    /// `CdcStartTime` or `CdcStartPosition` to specify when you want a
    /// CDC operation to start. Specifying both values results in an error.
    cdc_start_time: ?i64,

    /// Indicates when you want a change data capture (CDC) operation to stop. The
    /// value can be
    /// either server time or commit time.
    cdc_stop_position: ?[]const u8,

    /// Error and other information about why a serverless replication failed.
    failure_messages: ?[]const []const u8,

    /// Indicates whether the serverless replication is read-only. When set to
    /// `true`,
    /// this replication is managed by DMS as part of a zero-ETL integration and
    /// cannot be modified
    /// or deleted directly. You can only modify or delete read-only replications
    /// through their
    /// associated zero-ETL integration.
    is_read_only: ?bool,

    /// The status output of premigration assessment in describe-replications.
    premigration_assessment_statuses: ?[]const PremigrationAssessmentStatus,

    /// Information about provisioning resources for an DMS serverless replication.
    provision_data: ?ProvisionData,

    /// Indicates the last checkpoint that occurred during a change data capture
    /// (CDC)
    /// operation. You can provide this value to the `CdcStartPosition` parameter to
    /// start a CDC operation that begins at that checkpoint.
    recovery_checkpoint: ?[]const u8,

    /// The Amazon Resource Name for the `ReplicationConfig` associated with the
    /// replication.
    replication_config_arn: ?[]const u8,

    /// The identifier for the `ReplicationConfig` associated with the
    /// replication.
    replication_config_identifier: ?[]const u8,

    /// The time the serverless replication was created.
    replication_create_time: ?i64,

    /// The timestamp when DMS will deprovision the replication.
    replication_deprovision_time: ?i64,

    /// The timestamp when replication was last stopped.
    replication_last_stop_time: ?i64,

    /// This object provides a collection of statistics about a serverless
    /// replication.
    replication_stats: ?ReplicationStats,

    /// The type of the serverless replication.
    replication_type: ?MigrationTypeValue,

    /// The time the serverless replication was updated.
    replication_update_time: ?i64,

    /// The Amazon Resource Name for an existing `Endpoint` the serverless
    /// replication uses for its data source.
    source_endpoint_arn: ?[]const u8,

    /// The type of replication to start.
    start_replication_type: ?[]const u8,

    /// The current status of the serverless replication.
    status: ?[]const u8,

    /// The reason the replication task was stopped. This response parameter can
    /// return one of
    /// the following values:
    ///
    /// * `"Stop Reason NORMAL"`
    ///
    /// * `"Stop Reason RECOVERABLE_ERROR"`
    ///
    /// * `"Stop Reason FATAL_ERROR"`
    ///
    /// * `"Stop Reason FULL_LOAD_ONLY_FINISHED"`
    ///
    /// * `"Stop Reason STOPPED_AFTER_FULL_LOAD"` – Full load
    /// completed, with cached changes not applied
    ///
    /// * `"Stop Reason STOPPED_AFTER_CACHED_EVENTS"` – Full
    /// load completed, with cached changes applied
    ///
    /// * `"Stop Reason EXPRESS_LICENSE_LIMITS_REACHED"`
    ///
    /// * `"Stop Reason STOPPED_AFTER_DDL_APPLY"` – User-defined
    /// stop task after DDL applied
    ///
    /// * `"Stop Reason STOPPED_DUE_TO_LOW_MEMORY"`
    ///
    /// * `"Stop Reason STOPPED_DUE_TO_LOW_DISK"`
    ///
    /// * `"Stop Reason STOPPED_AT_SERVER_TIME"` – User-defined
    /// server time for stopping task
    ///
    /// * `"Stop Reason STOPPED_AT_COMMIT_TIME"` – User-defined
    /// commit time for stopping task
    ///
    /// * `"Stop Reason RECONFIGURATION_RESTART"`
    ///
    /// * `"Stop Reason RECYCLE_TASK"`
    stop_reason: ?[]const u8,

    /// The Amazon Resource Name for an existing `Endpoint` the serverless
    /// replication uses for its data target.
    target_endpoint_arn: ?[]const u8,

    pub const json_field_names = .{
        .cdc_start_position = "CdcStartPosition",
        .cdc_start_time = "CdcStartTime",
        .cdc_stop_position = "CdcStopPosition",
        .failure_messages = "FailureMessages",
        .is_read_only = "IsReadOnly",
        .premigration_assessment_statuses = "PremigrationAssessmentStatuses",
        .provision_data = "ProvisionData",
        .recovery_checkpoint = "RecoveryCheckpoint",
        .replication_config_arn = "ReplicationConfigArn",
        .replication_config_identifier = "ReplicationConfigIdentifier",
        .replication_create_time = "ReplicationCreateTime",
        .replication_deprovision_time = "ReplicationDeprovisionTime",
        .replication_last_stop_time = "ReplicationLastStopTime",
        .replication_stats = "ReplicationStats",
        .replication_type = "ReplicationType",
        .replication_update_time = "ReplicationUpdateTime",
        .source_endpoint_arn = "SourceEndpointArn",
        .start_replication_type = "StartReplicationType",
        .status = "Status",
        .stop_reason = "StopReason",
        .target_endpoint_arn = "TargetEndpointArn",
    };
};
