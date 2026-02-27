pub const ReportExportConfigType = enum {
    s3,
    no_export,

    pub const json_field_names = .{
        .s3 = "S3",
        .no_export = "NO_EXPORT",
    };
};
