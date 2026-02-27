pub const JdbcMetadataEntry = enum {
    comments,
    rawtypes,

    pub const json_field_names = .{
        .comments = "COMMENTS",
        .rawtypes = "RAWTYPES",
    };
};
