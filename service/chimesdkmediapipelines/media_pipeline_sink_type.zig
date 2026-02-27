pub const MediaPipelineSinkType = enum {
    s3_bucket,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
    };
};
