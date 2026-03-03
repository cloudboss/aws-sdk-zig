const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;

/// Describes the destination file system in the replication configuration.
pub const Destination = struct {
    /// The ID of the destination Amazon EFS file system.
    file_system_id: []const u8,

    /// The time when the most recent sync was successfully completed on the
    /// destination file
    /// system. Any changes to data on the source file system that occurred before
    /// this time have been
    /// successfully replicated to the destination file system. Any changes that
    /// occurred after this
    /// time might not be fully replicated.
    last_replicated_timestamp: ?i64 = null,

    /// ID of the Amazon Web Services account in which the destination file system
    /// resides.
    owner_id: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the destination file system is
    /// located.
    region: []const u8,

    /// Amazon Resource Name (ARN) of the IAM role in the source account that allows
    /// Amazon EFS to perform replication on its behalf. This is optional for
    /// same-account
    /// replication and required for cross-account replication.
    role_arn: ?[]const u8 = null,

    /// Describes the status of the replication configuration. For more information
    /// about replication status, see [Viewing
    /// replication
    /// details](https://docs.aws.amazon.com/efs/latest/ug/awsbackup.html#restoring-backup-efsmonitoring-replication-status.html) in the *Amazon EFS User Guide*.
    status: ReplicationStatus,

    /// Message that provides details about the `PAUSED` or `ERRROR` state
    /// of the replication destination configuration. For more information
    /// about replication status messages, see [Viewing
    /// replication
    /// details](https://docs.aws.amazon.com/efs/latest/ug/awsbackup.html#restoring-backup-efsmonitoring-replication-status.html) in the *Amazon EFS User Guide*.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .last_replicated_timestamp = "LastReplicatedTimestamp",
        .owner_id = "OwnerId",
        .region = "Region",
        .role_arn = "RoleArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
