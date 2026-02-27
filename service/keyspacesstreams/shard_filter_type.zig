pub const ShardFilterType = enum {
    child_shards,

    pub const json_field_names = .{
        .child_shards = "CHILD_SHARDS",
    };
};
