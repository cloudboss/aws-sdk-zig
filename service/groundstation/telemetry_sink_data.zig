const KinesisDataStreamData = @import("kinesis_data_stream_data.zig").KinesisDataStreamData;

/// Information about a telemetry sink.
pub const TelemetrySinkData = union(enum) {
    /// Information about a telemetry sink of type `KINESIS_DATA_STREAM`.
    kinesis_data_stream_data: ?KinesisDataStreamData,

    pub const json_field_names = .{
        .kinesis_data_stream_data = "kinesisDataStreamData",
    };
};
