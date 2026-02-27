const AssessmentReportDestinationType = @import("assessment_report_destination_type.zig").AssessmentReportDestinationType;

/// The location where Audit Manager saves assessment reports for the given
/// assessment.
pub const AssessmentReportsDestination = struct {
    /// The destination bucket where Audit Manager stores assessment reports.
    destination: ?[]const u8,

    /// The destination type, such as Amazon S3.
    destination_type: ?AssessmentReportDestinationType,

    pub const json_field_names = .{
        .destination = "destination",
        .destination_type = "destinationType",
    };
};
