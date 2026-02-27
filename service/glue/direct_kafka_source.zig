const StreamingDataPreviewOptions = @import("streaming_data_preview_options.zig").StreamingDataPreviewOptions;
const KafkaStreamingSourceOptions = @import("kafka_streaming_source_options.zig").KafkaStreamingSourceOptions;

/// Specifies an Apache Kafka data store.
pub const DirectKafkaSource = struct {
    /// Specifies options related to data preview for viewing a sample of your data.
    data_preview_options: ?StreamingDataPreviewOptions,

    /// Whether to automatically determine the schema from the incoming data.
    detect_schema: ?bool,

    /// The name of the data store.
    name: []const u8,

    /// Specifies the streaming options.
    streaming_options: ?KafkaStreamingSourceOptions,

    /// The amount of time to spend processing each micro batch.
    window_size: ?i32,

    pub const json_field_names = .{
        .data_preview_options = "DataPreviewOptions",
        .detect_schema = "DetectSchema",
        .name = "Name",
        .streaming_options = "StreamingOptions",
        .window_size = "WindowSize",
    };
};
