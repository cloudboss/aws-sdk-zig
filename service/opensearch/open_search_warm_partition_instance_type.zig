pub const OpenSearchWarmPartitionInstanceType = enum {
    ultrawarm_1_medium_search,
    ultrawarm_1_large_search,
    ultrawarm_1_xlarge_search,

    pub const json_field_names = .{
        .ultrawarm_1_medium_search = "ultrawarm1_medium_search",
        .ultrawarm_1_large_search = "ultrawarm1_large_search",
        .ultrawarm_1_xlarge_search = "ultrawarm1_xlarge_search",
    };
};
