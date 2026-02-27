const Status = @import("status.zig").Status;

/// The name of the shard.
pub const Shard = struct {
    /// The time when the shard was created in Universal Coordinated Time (UTC).
    create_time: []const u8,

    /// The ID of the shard.
    shard_id: []const u8,

    /// The current status of the shard.
    status: Status,

    pub const json_field_names = .{
        .create_time = "createTime",
        .shard_id = "shardId",
        .status = "status",
    };
};
