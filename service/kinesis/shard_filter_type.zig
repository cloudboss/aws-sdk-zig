pub const ShardFilterType = enum {
    after_shard_id,
    at_trim_horizon,
    from_trim_horizon,
    at_latest,
    at_timestamp,
    from_timestamp,

    pub const json_field_names = .{
        .after_shard_id = "AFTER_SHARD_ID",
        .at_trim_horizon = "AT_TRIM_HORIZON",
        .from_trim_horizon = "FROM_TRIM_HORIZON",
        .at_latest = "AT_LATEST",
        .at_timestamp = "AT_TIMESTAMP",
        .from_timestamp = "FROM_TIMESTAMP",
    };
};
