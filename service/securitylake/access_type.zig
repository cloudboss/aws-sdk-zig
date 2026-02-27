pub const AccessType = enum {
    lakeformation,
    s3,

    pub const json_field_names = .{
        .lakeformation = "LAKEFORMATION",
        .s3 = "S3",
    };
};
