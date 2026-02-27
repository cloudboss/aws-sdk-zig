pub const DeliveryStreamType = enum {
    direct_put,
    kinesis_stream_as_source,
    msk_as_source,
    database_as_source,

    pub const json_field_names = .{
        .direct_put = "DirectPut",
        .kinesis_stream_as_source = "KinesisStreamAsSource",
        .msk_as_source = "MSKAsSource",
        .database_as_source = "DatabaseAsSource",
    };
};
