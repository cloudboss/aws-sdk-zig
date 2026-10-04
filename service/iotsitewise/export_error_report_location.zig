/// Contains the location where error reports will be written on failure.
pub const ExportErrorReportLocation = struct {
    /// The S3 URI prefix for the error report.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
