const S3ReportOutputConfiguration = @import("s3_report_output_configuration.zig").S3ReportOutputConfiguration;

/// Configuration for report output destinations used in a Region switch plan.
pub const ReportOutputConfiguration = union(enum) {
    /// Configuration for delivering reports to an Amazon S3 bucket.
    s_3_configuration: ?S3ReportOutputConfiguration,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
