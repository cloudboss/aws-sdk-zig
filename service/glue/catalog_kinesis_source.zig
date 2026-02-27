const StreamingDataPreviewOptions = @import("streaming_data_preview_options.zig").StreamingDataPreviewOptions;
const KinesisStreamingSourceOptions = @import("kinesis_streaming_source_options.zig").KinesisStreamingSourceOptions;

/// Specifies a Kinesis data source in the Glue Data Catalog.
pub const CatalogKinesisSource = struct {
    /// The name of the database to read from.
    database: []const u8,

    /// Additional options for data preview.
    data_preview_options: ?StreamingDataPreviewOptions,

    /// Whether to automatically determine the schema from the incoming data.
    detect_schema: ?bool,

    /// The name of the data source.
    name: []const u8,

    /// Additional options for the Kinesis streaming data source.
    streaming_options: ?KinesisStreamingSourceOptions,

    /// The name of the table in the database to read from.
    table: []const u8,

    /// The amount of time to spend processing each micro batch.
    window_size: ?i32,

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
