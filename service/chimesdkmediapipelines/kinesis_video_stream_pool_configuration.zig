const KinesisVideoStreamPoolStatus = @import("kinesis_video_stream_pool_status.zig").KinesisVideoStreamPoolStatus;
const KinesisVideoStreamConfiguration = @import("kinesis_video_stream_configuration.zig").KinesisVideoStreamConfiguration;

/// The video stream pool configuration object.
pub const KinesisVideoStreamPoolConfiguration = struct {
    /// The time at which the configuration was created.
    created_timestamp: ?i64 = null,

    /// The ARN of the video stream pool configuration.
    pool_arn: ?[]const u8 = null,

    /// The ID of the video stream pool in the configuration.
    pool_id: ?[]const u8 = null,

    /// The name of the video stream pool configuration.
    pool_name: ?[]const u8 = null,

    /// The size of the video stream pool in the configuration.
    pool_size: ?i32 = null,

    /// The status of the video stream pool in the configuration.
    pool_status: ?KinesisVideoStreamPoolStatus = null,

    /// The Kinesis video stream pool configuration object.
    stream_configuration: ?KinesisVideoStreamConfiguration = null,

    /// The time at which the configuration was updated.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .pool_arn = "PoolArn",
        .pool_id = "PoolId",
        .pool_name = "PoolName",
        .pool_size = "PoolSize",
        .pool_status = "PoolStatus",
        .stream_configuration = "StreamConfiguration",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
