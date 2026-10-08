/// S3 location where report was written.
pub const S3ReportOutput = struct {
    /// The S3 object key for the generated report.
    s_3_object_key: []const u8,

    pub const json_field_names = .{
        .s_3_object_key = "s3ObjectKey",
    };
};
