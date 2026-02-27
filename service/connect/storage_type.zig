pub const StorageType = enum {
    s3,
    kinesis_video_stream,
    kinesis_stream,
    kinesis_firehose,

    pub const json_field_names = .{
        .s3 = "S3",
        .kinesis_video_stream = "KINESIS_VIDEO_STREAM",
        .kinesis_stream = "KINESIS_STREAM",
        .kinesis_firehose = "KINESIS_FIREHOSE",
    };
};
