pub const MergeOptionTypeEnum = enum {
    fast_forward_merge,
    squash_merge,
    three_way_merge,

    pub const json_field_names = .{
        .fast_forward_merge = "FAST_FORWARD_MERGE",
        .squash_merge = "SQUASH_MERGE",
        .three_way_merge = "THREE_WAY_MERGE",
    };
};
