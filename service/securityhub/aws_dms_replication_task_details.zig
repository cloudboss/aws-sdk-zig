/// Provides details about an Database Migration Service (DMS) replication task.
/// A replication task moves a set of data from the
/// source endpoint to the target endpoint.
pub const AwsDmsReplicationTaskDetails = struct {
    /// Indicates when you want a change data capture (CDC) operation to start.
    /// `CCdcStartPosition` or
    /// `CCdcStartTime` specifies when you want a CDC operation to start. Only a
    /// value for one of these fields
    /// is included.
    cdc_start_position: ?[]const u8,

    /// Indicates the start time for a CDC operation. `CdcStartPosition` or
    /// `CCdcStartTime` specifies
    /// when you want a CDC operation to start. Only a value for one of these fields
    /// is included.
    cdc_start_time: ?[]const u8,

    /// Indicates when you want a CDC operation to stop. The value can be either
    /// server time or commit time.
    cdc_stop_position: ?[]const u8,

    /// The identifier of the replication task.
    id: ?[]const u8,

    /// The migration type.
    migration_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a replication instance.
    replication_instance_arn: ?[]const u8,

    /// The user-defined replication task identifier or name.
    replication_task_identifier: ?[]const u8,

    /// The settings for the replication task.
    replication_task_settings: ?[]const u8,

    /// A display name for the resource identifier at the end of the `EndpointArn`
    /// response parameter.
    /// If you don't specify a `ResourceIdentifier` value, DMS generates a default
    /// identifier value for
    /// the end of `EndpointArn`.
    resource_identifier: ?[]const u8,

    /// The ARN of the source endpoint.
    source_endpoint_arn: ?[]const u8,

    /// The table mappings for the replication task, in JSON format.
    table_mappings: ?[]const u8,

    /// The ARN of the target endpoint.
    target_endpoint_arn: ?[]const u8,

    /// Supplemental information that the task requires to migrate the data for
    /// certain source and target endpoints.
    task_data: ?[]const u8,

    pub const json_field_names = .{
        .cdc_start_position = "CdcStartPosition",
        .cdc_start_time = "CdcStartTime",
        .cdc_stop_position = "CdcStopPosition",
        .id = "Id",
        .migration_type = "MigrationType",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_task_identifier = "ReplicationTaskIdentifier",
        .replication_task_settings = "ReplicationTaskSettings",
        .resource_identifier = "ResourceIdentifier",
        .source_endpoint_arn = "SourceEndpointArn",
        .table_mappings = "TableMappings",
        .target_endpoint_arn = "TargetEndpointArn",
        .task_data = "TaskData",
    };
};
