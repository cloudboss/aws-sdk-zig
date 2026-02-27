pub const DdbExportType = enum {
    ddb,
    s_3,

    pub const json_field_names = .{
        .ddb = "ddb",
        .s_3 = "s3",
    };
};
