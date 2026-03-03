/// Describes the error when experiment report generation has failed.
pub const ExperimentReportError = struct {
    /// The error code for the failed experiment report generation.
    code: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
    };
};
