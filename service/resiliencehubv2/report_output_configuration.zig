const S3ReportOutputConfiguration = @import("s3_report_output_configuration.zig").S3ReportOutputConfiguration;

/// Configuration for a report output destination.
pub const ReportOutputConfiguration = union(enum) {
    s_3: ?S3ReportOutputConfiguration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
