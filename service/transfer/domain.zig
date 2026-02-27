pub const Domain = enum {
    s3,
    efs,

    pub const json_field_names = .{
        .s3 = "S3",
        .efs = "EFS",
    };
};
