pub const ArtifactSourceIdType = enum {
    md5_hash,
    s3_etag,
    s3_version,
    custom,

    pub const json_field_names = .{
        .md5_hash = "MD5_HASH",
        .s3_etag = "S3_ETAG",
        .s3_version = "S3_VERSION",
        .custom = "CUSTOM",
    };
};
