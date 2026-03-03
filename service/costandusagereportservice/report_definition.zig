const AdditionalArtifact = @import("additional_artifact.zig").AdditionalArtifact;
const SchemaElement = @import("schema_element.zig").SchemaElement;
const CompressionFormat = @import("compression_format.zig").CompressionFormat;
const ReportFormat = @import("report_format.zig").ReportFormat;
const ReportStatus = @import("report_status.zig").ReportStatus;
const ReportVersioning = @import("report_versioning.zig").ReportVersioning;
const AWSRegion = @import("aws_region.zig").AWSRegion;
const TimeUnit = @import("time_unit.zig").TimeUnit;

/// The definition of Amazon Web Services Cost and Usage Report. You can specify
/// the report name,
/// time unit, report format, compression format, S3 bucket, additional
/// artifacts, and schema
/// elements in the definition.
pub const ReportDefinition = struct {
    /// A list of manifests that you want Amazon Web Services to create for this
    /// report.
    additional_artifacts: ?[]const AdditionalArtifact = null,

    /// A list of strings that indicate additional content that Amazon Web Services
    /// includes in the report, such as individual resource IDs.
    additional_schema_elements: []const SchemaElement,

    /// The Amazon resource name of the billing view. The `BillingViewArn` is needed
    /// to create Amazon Web Services Cost and Usage Report for each billing group
    /// maintained in the Amazon Web Services Billing Conductor service. The
    /// `BillingViewArn` for a billing group can be constructed as:
    /// `arn:aws:billing::payer-account-id:billingview/billing-group-primary-account-id`
    billing_view_arn: ?[]const u8 = null,

    compression: CompressionFormat,

    format: ReportFormat,

    /// Whether you want Amazon Web Services to update your reports after they have
    /// been finalized if Amazon Web Services detects charges related to
    /// previous months. These charges can include refunds, credits, or support
    /// fees.
    refresh_closed_reports: ?bool = null,

    report_name: []const u8,

    /// The status of the report.
    report_status: ?ReportStatus = null,

    /// Whether you want Amazon Web Services to overwrite the previous version of
    /// each report or
    /// to deliver the report in addition to the previous versions.
    report_versioning: ?ReportVersioning = null,

    s3_bucket: []const u8,

    s3_prefix: []const u8,

    s3_region: AWSRegion,

    time_unit: TimeUnit,

    pub const json_field_names = .{
        .additional_artifacts = "AdditionalArtifacts",
        .additional_schema_elements = "AdditionalSchemaElements",
        .billing_view_arn = "BillingViewArn",
        .compression = "Compression",
        .format = "Format",
        .refresh_closed_reports = "RefreshClosedReports",
        .report_name = "ReportName",
        .report_status = "ReportStatus",
        .report_versioning = "ReportVersioning",
        .s3_bucket = "S3Bucket",
        .s3_prefix = "S3Prefix",
        .s3_region = "S3Region",
        .time_unit = "TimeUnit",
    };
};
