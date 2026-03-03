const ShardConfiguration = @import("shard_configuration.zig").ShardConfiguration;

/// Provides details of a shard in a snapshot
pub const ShardDetail = struct {
    /// The configuration details of the shard
    configuration: ?ShardConfiguration = null,

    /// The name of the shard
    name: ?[]const u8 = null,

    /// The size of the shard's snapshot
    size: ?[]const u8 = null,

    /// The date and time that the shard's snapshot was created
    snapshot_creation_time: ?i64 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .name = "Name",
        .size = "Size",
        .snapshot_creation_time = "SnapshotCreationTime",
    };
};
