pub const LogDestinationType = enum {
    s3,
    cloudwatch_logs,
    kinesis_data_firehose,

    pub const json_field_names = .{
        .s3 = "S3",
        .cloudwatch_logs = "CLOUDWATCH_LOGS",
        .kinesis_data_firehose = "KINESIS_DATA_FIREHOSE",
    };
};
