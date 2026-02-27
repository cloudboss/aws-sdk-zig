const EdgeConfig = @import("edge_config.zig").EdgeConfig;
const SyncStatus = @import("sync_status.zig").SyncStatus;

/// A description of a single stream's edge configuration.
pub const ListEdgeAgentConfigurationsEdgeConfig = struct {
    /// The timestamp when the stream first created the edge config.
    creation_time: ?i64,

    edge_config: ?EdgeConfig,

    /// A description of the generated failure status.
    failed_status_details: ?[]const u8,

    /// The timestamp when the stream last updated the edge config.
    last_updated_time: ?i64,

    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8,

    /// The name of the stream.
    stream_name: ?[]const u8,

    /// The current sync status of the stream's edge configuration.
    sync_status: ?SyncStatus,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .edge_config = "EdgeConfig",
        .failed_status_details = "FailedStatusDetails",
        .last_updated_time = "LastUpdatedTime",
        .stream_arn = "StreamARN",
        .stream_name = "StreamName",
        .sync_status = "SyncStatus",
    };
};
