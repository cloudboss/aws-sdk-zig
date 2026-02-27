pub const ProcessingS3DataType = enum {
    manifest_file,
    s3_prefix,

    pub const json_field_names = .{
        .manifest_file = "MANIFEST_FILE",
        .s3_prefix = "S3_PREFIX",
    };
};
