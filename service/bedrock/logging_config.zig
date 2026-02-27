const CloudWatchConfig = @import("cloud_watch_config.zig").CloudWatchConfig;
const S3Config = @import("s3_config.zig").S3Config;

/// Configuration fields for invocation logging.
pub const LoggingConfig = struct {
    /// Set to include audio data in the log delivery.
    audio_data_delivery_enabled: ?bool,

    /// CloudWatch logging configuration.
    cloud_watch_config: ?CloudWatchConfig,

    /// Set to include embeddings data in the log delivery.
    embedding_data_delivery_enabled: ?bool,

    /// Set to include image data in the log delivery.
    image_data_delivery_enabled: ?bool,

    /// S3 configuration for storing log data.
    s_3_config: ?S3Config,

    /// Set to include text data in the log delivery.
    text_data_delivery_enabled: ?bool,

    /// Set to include video data in the log delivery.
    video_data_delivery_enabled: ?bool,

    pub const json_field_names = .{
        .audio_data_delivery_enabled = "audioDataDeliveryEnabled",
        .cloud_watch_config = "cloudWatchConfig",
        .embedding_data_delivery_enabled = "embeddingDataDeliveryEnabled",
        .image_data_delivery_enabled = "imageDataDeliveryEnabled",
        .s_3_config = "s3Config",
        .text_data_delivery_enabled = "textDataDeliveryEnabled",
        .video_data_delivery_enabled = "videoDataDeliveryEnabled",
    };
};
