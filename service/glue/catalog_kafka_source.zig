const StreamingDataPreviewOptions = @import("streaming_data_preview_options.zig").StreamingDataPreviewOptions;
const KafkaStreamingSourceOptions = @import("kafka_streaming_source_options.zig").KafkaStreamingSourceOptions;

/// Specifies an Apache Kafka data store in the Data Catalog.
pub const CatalogKafkaSource = struct {
    /// The name of the database to read from.
    database: []const u8,

    /// Specifies options related to data preview for viewing a sample of your data.
    data_preview_options: ?StreamingDataPreviewOptions = null,

    /// Whether to automatically determine the schema from the incoming data.
    detect_schema: ?bool = null,

    /// The name of the data store.
    name: []const u8,

    /// Specifies the streaming options.
    streaming_options: ?KafkaStreamingSourceOptions = null,

    /// The name of the table in the database to read from.
    table: []const u8,

    /// The amount of time to spend processing each micro batch.
    window_size: ?i32 = null,

    pub const json_field_names = .{
        .database = "Database",
        .data_preview_options = "DataPreviewOptions",
        .detect_schema = "DetectSchema",
        .name = "Name",
        .streaming_options = "StreamingOptions",
        .table = "Table",
        .window_size = "WindowSize",
    };
};
