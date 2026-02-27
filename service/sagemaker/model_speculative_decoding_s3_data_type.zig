pub const ModelSpeculativeDecodingS3DataType = enum {
    s3_prefix,
    manifest_file,

    pub const json_field_names = .{
        .s3_prefix = "S3Prefix",
        .manifest_file = "ManifestFile",
    };
};
