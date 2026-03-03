const MediaStorageConfigurationStatus = @import("media_storage_configuration_status.zig").MediaStorageConfigurationStatus;

/// A structure that encapsulates, or contains, the media storage configuration
/// properties.
///
/// * If `StorageStatus` is enabled, the data will be stored in the
/// `StreamARN` provided. In order for WebRTC Ingestion to work, the stream must
/// have data retention
/// enabled.
///
/// * If `StorageStatus` is disabled, no data will be stored, and the
/// `StreamARN` parameter will not be needed.
pub const MediaStorageConfiguration = struct {
    /// The status of the media storage configuration.
    status: MediaStorageConfigurationStatus,

    /// The Amazon Resource Name (ARN) of the stream.
    stream_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .stream_arn = "StreamARN",
    };
};
