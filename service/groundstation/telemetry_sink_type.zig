pub const TelemetrySinkType = enum {
    kinesis_data_stream,

    pub const json_field_names = .{
        .kinesis_data_stream = "KINESIS_DATA_STREAM",
    };
};
