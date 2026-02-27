const ReportContext = @import("report_context.zig").ReportContext;
const ReportFrequency = @import("report_frequency.zig").ReportFrequency;
const ReportType = @import("report_type.zig").ReportType;
const S3Location = @import("s3_location.zig").S3Location;
const Tag = @import("tag.zig").Tag;

/// Describe the details of a report generator.
pub const ReportGenerator = struct {
    /// Time the report was created.
    create_time: ?[]const u8,

    /// Description of the report generator.
    description: ?[]const u8,

    /// Time the last report was generated at.
    last_report_generation_time: ?[]const u8,

    /// Failure message for the last report generation attempt.
    last_run_failure_reason: ?[]const u8,

    /// Status of the last report generation attempt.
    last_run_status: ?[]const u8,

    /// Amazon Resource Name (ARN) of the report generator.
    license_manager_report_generator_arn: ?[]const u8,

    /// License configuration type for this generator.
    report_context: ?ReportContext,

    /// The Amazon Web Services account ID used to create the report generator.
    report_creator_account: ?[]const u8,

    /// Details about how frequently reports are generated.
    report_frequency: ?ReportFrequency,

    /// Name of the report generator.
    report_generator_name: ?[]const u8,

    /// Type of reports that are generated.
    report_type: ?[]const ReportType,

    /// Details of the S3 bucket that report generator reports are published to.
    s3_location: ?S3Location,

    /// Tags associated with the report generator.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .description = "Description",
        .last_report_generation_time = "LastReportGenerationTime",
        .last_run_failure_reason = "LastRunFailureReason",
        .last_run_status = "LastRunStatus",
        .license_manager_report_generator_arn = "LicenseManagerReportGeneratorArn",
        .report_context = "ReportContext",
        .report_creator_account = "ReportCreatorAccount",
        .report_frequency = "ReportFrequency",
        .report_generator_name = "ReportGeneratorName",
        .report_type = "ReportType",
        .s3_location = "S3Location",
        .tags = "Tags",
    };
};
