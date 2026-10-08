const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

/// Contains information about an S3 File System returned in list operations.
pub const ListFileSystemsDescription = struct {
    /// The Amazon Resource Name (ARN) of the S3 bucket.
    bucket: []const u8,

    /// The time when the file system was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the file system.
    file_system_arn: []const u8,

    /// The ID of the file system.
    file_system_id: []const u8,

    /// The name of the file system.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the file system owner.
    owner_id: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role used for S3 access.
    role_arn: []const u8,

    /// The current status of the file system.
    status: LifeCycleState,

    /// Additional information about the file system status.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .creation_time = "creationTime",
        .file_system_arn = "fileSystemArn",
        .file_system_id = "fileSystemId",
        .name = "name",
        .owner_id = "ownerId",
        .role_arn = "roleArn",
        .status = "status",
        .status_message = "statusMessage",
    };
};
