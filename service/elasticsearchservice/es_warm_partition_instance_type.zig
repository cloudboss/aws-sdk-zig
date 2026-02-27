pub const ESWarmPartitionInstanceType = enum {
    ultrawarm_1_medium_elasticsearch,
    ultrawarm_1_large_elasticsearch,

    pub const json_field_names = .{
        .ultrawarm_1_medium_elasticsearch = "ultrawarm1_medium_elasticsearch",
        .ultrawarm_1_large_elasticsearch = "ultrawarm1_large_elasticsearch",
    };
};
