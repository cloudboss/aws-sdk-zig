const LastSuccessfulReplicatedUpdate = @import("last_successful_replicated_update.zig").LastSuccessfulReplicatedUpdate;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// Contains status information for a replication destination, including the
/// current replication state, last successful update, and any error messages.
pub const ReplicationDestinationStatusModel = struct {
    /// The Amazon Resource Name (ARN) of the destination table.
    destination_table_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the destination table bucket.
    destination_table_bucket_arn: []const u8,

    /// If replication has failed, this field contains an error message describing
    /// the failure reason.
    failure_message: ?[]const u8,

    /// Information about the most recent successful replication update to this
    /// destination.
    last_successful_replicated_update: ?LastSuccessfulReplicatedUpdate,

    /// The current status of replication to this destination.
    replication_status: ReplicationStatus,

    pub const json_field_names = .{
        .destination_table_arn = "destinationTableArn",
        .destination_table_bucket_arn = "destinationTableBucketArn",
        .failure_message = "failureMessage",
        .last_successful_replicated_update = "lastSuccessfulReplicatedUpdate",
        .replication_status = "replicationStatus",
    };
};
