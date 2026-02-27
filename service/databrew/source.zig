pub const Source = enum {
    s3,
    datacatalog,
    database,

    pub const json_field_names = .{
        .s3 = "S3",
        .datacatalog = "DATACATALOG",
        .database = "DATABASE",
    };
};
