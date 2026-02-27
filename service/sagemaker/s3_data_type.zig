pub const S3DataType = enum {
    manifest_file,
    s3_prefix,
    augmented_manifest_file,
    converse,

    pub const json_field_names = .{
        .manifest_file = "MANIFEST_FILE",
        .s3_prefix = "S3_PREFIX",
        .augmented_manifest_file = "AUGMENTED_MANIFEST_FILE",
        .converse = "CONVERSE",
    };
};
