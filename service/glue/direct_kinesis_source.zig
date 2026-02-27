const StreamingDataPreviewOptions = @import("streaming_data_preview_options.zig").StreamingDataPreviewOptions;
const KinesisStreamingSourceOptions = @import("kinesis_streaming_source_options.zig").KinesisStreamingSourceOptions;

/// Specifies a direct Amazon Kinesis data source.
pub const DirectKinesisSource = struct {
    /// Additional options for data preview.
    data_preview_options: ?StreamingDataPreviewOptions,

    /// Whether to automatically determine the schema from the incoming data.
    detect_schema: ?bool,

    /// The name of the data source.
    name: []const u8,

    /// Additional options for the Kinesis streaming data source.
    streaming_options: ?KinesisStreamingSourceOptions,

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
