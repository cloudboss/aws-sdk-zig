pub const SourceType = enum {
    s3,
    iotsitewise,
    iottwinmaker,

    pub const json_field_names = .{
        .s3 = "S3",
        .iotsitewise = "IOTSITEWISE",
        .iottwinmaker = "IOTTWINMAKER",
    };
};
