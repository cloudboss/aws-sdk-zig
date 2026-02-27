pub const S3DataDistribution = enum {
    fully_replicated,
    sharded_by_s3_key,

    pub const json_field_names = .{
        .fully_replicated = "FULLY_REPLICATED",
        .sharded_by_s3_key = "SHARDED_BY_S3_KEY",
    };
};
