pub const ReadSetFile = enum {
    source1,
    source2,
    index,

    pub const json_field_names = .{
        .source1 = "SOURCE1",
        .source2 = "SOURCE2",
        .index = "INDEX",
    };
};
