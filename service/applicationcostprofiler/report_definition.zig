const S3Location = @import("s3_location.zig").S3Location;
const Format = @import("format.zig").Format;
const ReportFrequency = @import("report_frequency.zig").ReportFrequency;

/// The configuration of a report in AWS Application Cost Profiler.
pub const ReportDefinition = struct {
    /// Timestamp (milliseconds) when this report definition was created.
    created_at: ?i64,

    /// The location in Amazon Simple Storage Service (Amazon S3) the reports should
    /// be saved to.
    destination_s3_location: ?S3Location,

    /// The format used for the generated reports.
    format: ?Format,

    /// Timestamp (milliseconds) when this report definition was last updated.
    last_updated_at: ?i64,

    /// Description of the report
    report_description: ?[]const u8,

    /// The cadence at which the report is generated.
    report_frequency: ?ReportFrequency,

    /// The ID of the report.
    report_id: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .destination_s3_location = "destinationS3Location",
        .format = "format",
        .last_updated_at = "lastUpdatedAt",
        .report_description = "reportDescription",
        .report_frequency = "reportFrequency",
        .report_id = "reportId",
    };
};
