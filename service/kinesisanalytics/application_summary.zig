const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

/// This documentation is for version 1 of the Amazon Kinesis Data Analytics
/// API, which only supports SQL applications. Version 2 of the API supports SQL
/// and Java applications. For more information about version 2, see [Amazon
/// Kinesis Data Analytics API V2
/// Documentation](/kinesisanalytics/latest/apiv2/Welcome.html).
///
/// Provides application summary information, including the application Amazon
/// Resource Name (ARN), name, and status.
pub const ApplicationSummary = struct {
    /// ARN of the application.
    application_arn: []const u8,

    /// Name of the application.
    application_name: []const u8,

    /// Status of the application.
    application_status: ApplicationStatus,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_name = "ApplicationName",
        .application_status = "ApplicationStatus",
    };
};
