const ErrorInfo = @import("error_info.zig").ErrorInfo;
const IngestionStatus = @import("ingestion_status.zig").IngestionStatus;
const QueueInfo = @import("queue_info.zig").QueueInfo;
const IngestionRequestSource = @import("ingestion_request_source.zig").IngestionRequestSource;
const IngestionRequestType = @import("ingestion_request_type.zig").IngestionRequestType;
const RowInfo = @import("row_info.zig").RowInfo;

/// Information about the SPICE ingestion for a dataset.
pub const Ingestion = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: []const u8,

    /// The time that this ingestion started.
    created_time: i64,

    /// Error information for this ingestion.
    error_info: ?ErrorInfo,

    /// Ingestion ID.
    ingestion_id: ?[]const u8,

    /// The size of the data ingested, in bytes.
    ingestion_size_in_bytes: ?i64,

    /// Ingestion status.
    ingestion_status: IngestionStatus,

    /// The time that this ingestion took, measured in seconds.
    ingestion_time_in_seconds: ?i64,

    queue_info: ?QueueInfo,

    /// Event source for this ingestion.
    request_source: ?IngestionRequestSource,

    /// Type of this ingestion.
    request_type: ?IngestionRequestType,

    row_info: ?RowInfo,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .error_info = "ErrorInfo",
        .ingestion_id = "IngestionId",
        .ingestion_size_in_bytes = "IngestionSizeInBytes",
        .ingestion_status = "IngestionStatus",
        .ingestion_time_in_seconds = "IngestionTimeInSeconds",
        .queue_info = "QueueInfo",
        .request_source = "RequestSource",
        .request_type = "RequestType",
        .row_info = "RowInfo",
    };
};
