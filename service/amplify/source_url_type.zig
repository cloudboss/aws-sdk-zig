pub const SourceUrlType = enum {
    zip,
    bucket_prefix,

    pub const json_field_names = .{
        .zip = "ZIP",
        .bucket_prefix = "BUCKET_PREFIX",
    };
};
