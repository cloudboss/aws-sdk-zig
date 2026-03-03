const ApplicationStatus = @import("application_status.zig").ApplicationStatus;
const CloudWatchLoggingOptionDescription = @import("cloud_watch_logging_option_description.zig").CloudWatchLoggingOptionDescription;
const InputDescription = @import("input_description.zig").InputDescription;
const OutputDescription = @import("output_description.zig").OutputDescription;
const ReferenceDataSourceDescription = @import("reference_data_source_description.zig").ReferenceDataSourceDescription;

/// This documentation is for version 1 of the Amazon Kinesis Data Analytics
/// API, which only supports SQL applications. Version 2 of the API supports SQL
/// and Java applications. For more information about version 2, see [Amazon
/// Kinesis Data Analytics API V2
/// Documentation](/kinesisanalytics/latest/apiv2/Welcome.html).
///
/// Provides a description of the application, including the application Amazon
/// Resource Name (ARN), status, latest version, and input and output
/// configuration.
pub const ApplicationDetail = struct {
    /// ARN of the application.
    application_arn: []const u8,

    /// Returns the application code that you provided to perform data analysis on
    /// any of the in-application streams in your application.
    application_code: ?[]const u8 = null,

    /// Description of the application.
    application_description: ?[]const u8 = null,

    /// Name of the application.
    application_name: []const u8,

    /// Status of the application.
    application_status: ApplicationStatus,

    /// Provides the current application version.
    application_version_id: i64,

    /// Describes the CloudWatch log streams that are configured to receive
    /// application
    /// messages. For more information about using CloudWatch log streams with
    /// Amazon Kinesis
    /// Analytics applications, see [Working with Amazon
    /// CloudWatch
    /// Logs](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/cloudwatch-logs.html).
    cloud_watch_logging_option_descriptions: ?[]const CloudWatchLoggingOptionDescription = null,

    /// Time stamp when the application version was created.
    create_timestamp: ?i64 = null,

    /// Describes the application input configuration.
    /// For more information,
    /// see [Configuring Application
    /// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
    input_descriptions: ?[]const InputDescription = null,

    /// Time stamp when the application was last updated.
    last_update_timestamp: ?i64 = null,

    /// Describes the application output configuration.
    /// For more information,
    /// see [Configuring Application
    /// Output](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-output.html).
    output_descriptions: ?[]const OutputDescription = null,

    /// Describes reference data sources configured for the application.
    ///
    /// For more information,
    /// see [Configuring Application
    /// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
    reference_data_source_descriptions: ?[]const ReferenceDataSourceDescription = null,

    pub const json_field_names = .{
        .application_arn = "ApplicationARN",
        .application_code = "ApplicationCode",
        .application_description = "ApplicationDescription",
        .application_name = "ApplicationName",
        .application_status = "ApplicationStatus",
        .application_version_id = "ApplicationVersionId",
        .cloud_watch_logging_option_descriptions = "CloudWatchLoggingOptionDescriptions",
        .create_timestamp = "CreateTimestamp",
        .input_descriptions = "InputDescriptions",
        .last_update_timestamp = "LastUpdateTimestamp",
        .output_descriptions = "OutputDescriptions",
        .reference_data_source_descriptions = "ReferenceDataSourceDescriptions",
    };
};
