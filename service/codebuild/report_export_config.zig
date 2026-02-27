const ReportExportConfigType = @import("report_export_config_type.zig").ReportExportConfigType;
const S3ReportExportConfig = @import("s3_report_export_config.zig").S3ReportExportConfig;

/// Information about the location where the run of a report is exported.
pub const ReportExportConfig = struct {
    /// The export configuration type. Valid values are:
    ///
    /// * `S3`: The report results are exported to an S3 bucket.
    ///
    /// * `NO_EXPORT`: The report results are not exported.
    export_config_type: ?ReportExportConfigType,

    /// A `S3ReportExportConfig` object that contains information about the S3
    /// bucket where the run of a report is exported.
    s_3_destination: ?S3ReportExportConfig,

    pub const json_field_names = .{
        .export_config_type = "exportConfigType",
        .s_3_destination = "s3Destination",
    };
};
