pub const ReferenceFile = enum {
    source,
    index,

    pub const json_field_names = .{
        .source = "SOURCE",
        .index = "INDEX",
    };
};
