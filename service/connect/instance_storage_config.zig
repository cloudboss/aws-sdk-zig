const KinesisFirehoseConfig = @import("kinesis_firehose_config.zig").KinesisFirehoseConfig;
const KinesisStreamConfig = @import("kinesis_stream_config.zig").KinesisStreamConfig;
const KinesisVideoStreamConfig = @import("kinesis_video_stream_config.zig").KinesisVideoStreamConfig;
const S3Config = @import("s3_config.zig").S3Config;
const StorageType = @import("storage_type.zig").StorageType;

/// The storage configuration for the instance.
pub const InstanceStorageConfig = struct {
    /// The existing association identifier that uniquely identifies the resource
    /// type and storage config for the given instance ID.
    association_id: ?[]const u8 = null,

    /// The configuration of the Kinesis Firehose delivery stream.
    kinesis_firehose_config: ?KinesisFirehoseConfig = null,

    /// The configuration of the Kinesis data stream.
    kinesis_stream_config: ?KinesisStreamConfig = null,

    /// The configuration of the Kinesis video stream.
    kinesis_video_stream_config: ?KinesisVideoStreamConfig = null,

    /// The S3 bucket
    /// configuration.
    s3_config: ?S3Config = null,

    /// A valid storage type.
    storage_type: StorageType,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .kinesis_firehose_config = "KinesisFirehoseConfig",
        .kinesis_stream_config = "KinesisStreamConfig",
        .kinesis_video_stream_config = "KinesisVideoStreamConfig",
        .s3_config = "S3Config",
        .storage_type = "StorageType",
    };
};
