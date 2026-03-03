/// Information about a report delivered to Amazon S3.
pub const S3ReportOutput = struct {
    /// The S3 object key where the generated report is stored.
    s_3_object_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_object_key = "s3ObjectKey",
    };
};
