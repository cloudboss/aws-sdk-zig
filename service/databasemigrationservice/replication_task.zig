const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const ReplicationTaskStats = @import("replication_task_stats.zig").ReplicationTaskStats;

/// Provides information that describes a replication task created by the
/// `CreateReplicationTask` operation.
pub const ReplicationTask = struct {
    /// Indicates when you want a change data capture (CDC) operation to start. Use
    /// either
    /// `CdcStartPosition` or `CdcStartTime` to specify when you want the
    /// CDC operation to start. Specifying both values results in an error.
    ///
    /// The value can be in date, checkpoint, or LSN/SCN format.
    ///
    /// Date Example: --cdc-start-position “2018-03-08T12:12:12”
    ///
    /// Checkpoint Example: --cdc-start-position
    /// "checkpoint:V1#27#mysql-bin-changelog.157832:1975:-1:2002:677883278264080:mysql-bin-changelog.157832:1876#0#0#*#0#93"
    ///
    /// LSN Example: --cdc-start-position “mysql-bin-changelog.000024:373”
    cdc_start_position: ?[]const u8 = null,

    /// Indicates when you want a change data capture (CDC) operation to stop. The
    /// value can be
    /// either server time or commit time.
    ///
    /// Server time example: --cdc-stop-position “server_time:2018-02-09T12:12:12”
    ///
    /// Commit time example: --cdc-stop-position “commit_time:2018-02-09T12:12:12“
    cdc_stop_position: ?[]const u8 = null,

    /// The last error (failure) message generated for the replication task.
    last_failure_message: ?[]const u8 = null,

    /// The type of migration.
    migration_type: ?MigrationTypeValue = null,

    /// Indicates the last checkpoint that occurred during a change data capture
    /// (CDC)
    /// operation. You can provide this value to the `CdcStartPosition` parameter to
    /// start a CDC operation that begins at that checkpoint.
    recovery_checkpoint: ?[]const u8 = null,

    /// The ARN of the replication instance.
    replication_instance_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replication task.
    replication_task_arn: ?[]const u8 = null,

    /// The date the replication task was created.
    replication_task_creation_date: ?i64 = null,

    /// The user-assigned replication task identifier or name.
    ///
    /// Constraints:
    ///
    /// * Must contain 1-255 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Cannot end with a hyphen or contain two consecutive hyphens.
    replication_task_identifier: ?[]const u8 = null,

    /// The settings for the replication task.
    replication_task_settings: ?[]const u8 = null,

    /// The date the replication task is scheduled to start.
    replication_task_start_date: ?i64 = null,

    /// The statistics for the task, including elapsed time, tables loaded, and
    /// table
    /// errors.
    replication_task_stats: ?ReplicationTaskStats = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the endpoint.
    source_endpoint_arn: ?[]const u8 = null,

    /// The status of the replication task. This response parameter can return one
    /// of the
    /// following values:
    ///
    /// * `"moving"` – The task is being moved in response to
    /// running the [
    /// `MoveReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_MoveReplicationTask.html) operation.
    ///
    /// * `"creating"` – The task is being created in response
    /// to running the [
    /// `CreateReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_CreateReplicationTask.html) operation.
    ///
    /// * `"deleting"` – The task is being deleted in response
    /// to running the [
    /// `DeleteReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_DeleteReplicationTask.html) operation.
    ///
    /// * `"failed"` – The task failed to successfully complete
    /// the database migration in response to running the [
    /// `StartReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html) operation.
    ///
    /// * `"failed-move"` – The task failed to move in response
    /// to running the [
    /// `MoveReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_MoveReplicationTask.html) operation.
    ///
    /// * `"modifying"` – The task definition is being modified
    /// in response to running the [
    /// `ModifyReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_ModifyReplicationTask.html) operation.
    ///
    /// * `"ready"` – The task is in a `ready` state
    /// where it can respond to other task operations, such as [
    /// `StartReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html) or [
    /// `DeleteReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_DeleteReplicationTask.html).
    ///
    /// * `"running"` – The task is performing a database
    /// migration in response to running the [
    /// `StartReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html) operation.
    ///
    /// * `"starting"` – The task is preparing to perform a
    /// database migration in response to running the [
    /// `StartReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTask.html) operation.
    ///
    /// * `"stopped"` – The task has stopped in response to
    /// running the [
    /// `StopReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StopReplicationTask.html) operation.
    ///
    /// * `"stopping"` – The task is preparing to stop in
    /// response to running the [
    /// `StopReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StopReplicationTask.html) operation.
    ///
    /// * `"testing"` – The database migration specified for
    /// this task is being tested in response to running either the [
    /// `StartReplicationTaskAssessmentRun`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTaskAssessmentRun.html) or the
    /// [
    /// `StartReplicationTaskAssessment`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTaskAssessment.html)
    /// operation.
    ///
    /// [
    /// `StartReplicationTaskAssessmentRun`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTaskAssessmentRun.html) is
    /// an improved premigration task assessment operation. The [
    /// `StartReplicationTaskAssessment`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTaskAssessment.html)
    /// operation assesses data type compatibility only between the source and
    /// target
    /// database of a given migration task. In contrast, [
    /// `StartReplicationTaskAssessmentRun`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_StartReplicationTaskAssessmentRun.html)
    /// enables you to specify a variety of premigration task assessments in
    /// addition to
    /// data type compatibility. These assessments include ones for the validity of
    /// primary key definitions and likely issues with database migration
    /// performance,
    /// among others.
    status: ?[]const u8 = null,

    /// The reason the replication task was stopped. This response parameter can
    /// return one of
    /// the following values:
    ///
    /// * `"Stop Reason NORMAL"` – The task completed
    /// successfully with no additional information returned.
    ///
    /// * `"Stop Reason RECOVERABLE_ERROR"`
    ///
    /// * `"Stop Reason FATAL_ERROR"`
    ///
    /// * `"Stop Reason FULL_LOAD_ONLY_FINISHED"` – The task
    /// completed the full load phase. DMS applied cached changes if you set
    /// `StopTaskCachedChangesApplied` to `true`.
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
    stop_reason: ?[]const u8 = null,

    /// Table mappings specified in the task.
    table_mappings: ?[]const u8 = null,

    /// The ARN that uniquely identifies the endpoint.
    target_endpoint_arn: ?[]const u8 = null,

    /// The ARN of the replication instance to which this task is moved in response
    /// to running
    /// the [
    /// `MoveReplicationTask`
    /// ](https://docs.aws.amazon.com/dms/latest/APIReference/API_MoveReplicationTask.html) operation. Otherwise, this response
    /// parameter isn't a member of the `ReplicationTask` object.
    target_replication_instance_arn: ?[]const u8 = null,

    /// Supplemental information that the task requires to migrate the data for
    /// certain source
    /// and target endpoints. For more information, see [Specifying Supplemental
    /// Data for
    /// Task
    /// Settings](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.TaskData.html) in the *Database Migration Service User Guide.*
    task_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .cdc_start_position = "CdcStartPosition",
        .cdc_stop_position = "CdcStopPosition",
        .last_failure_message = "LastFailureMessage",
        .migration_type = "MigrationType",
        .recovery_checkpoint = "RecoveryCheckpoint",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_task_arn = "ReplicationTaskArn",
        .replication_task_creation_date = "ReplicationTaskCreationDate",
        .replication_task_identifier = "ReplicationTaskIdentifier",
        .replication_task_settings = "ReplicationTaskSettings",
        .replication_task_start_date = "ReplicationTaskStartDate",
        .replication_task_stats = "ReplicationTaskStats",
        .source_endpoint_arn = "SourceEndpointArn",
        .status = "Status",
        .stop_reason = "StopReason",
        .table_mappings = "TableMappings",
        .target_endpoint_arn = "TargetEndpointArn",
        .target_replication_instance_arn = "TargetReplicationInstanceArn",
        .task_data = "TaskData",
    };
};
