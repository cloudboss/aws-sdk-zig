const aws = @import("aws");

const MonitoringProblemType = @import("monitoring_problem_type.zig").MonitoringProblemType;

/// Container image configuration object for the monitoring job.
pub const ModelQualityAppSpecification = struct {
    /// An array of arguments for the container used to run the monitoring job.
    container_arguments: ?[]const []const u8,

    /// Specifies the entrypoint for a container that the monitoring job runs.
    container_entrypoint: ?[]const []const u8,

    /// Sets the environment variables in the container that the monitoring job
    /// runs.
    environment: ?[]const aws.map.StringMapEntry,

    /// The address of the container image that the monitoring job runs.
    image_uri: []const u8,

    /// An Amazon S3 URI to a script that is called after analysis has been
    /// performed. Applicable only for the built-in (first party) containers.
    post_analytics_processor_source_uri: ?[]const u8,

    /// The machine learning problem type of the model that the monitoring job
    /// monitors.
    problem_type: ?MonitoringProblemType,

    /// An Amazon S3 URI to a script that is called per row prior to running
    /// analysis. It can base64 decode the payload and convert it into a flattened
    /// JSON so that the built-in container can use the converted data. Applicable
    /// only for the built-in (first party) containers.
    record_preprocessor_source_uri: ?[]const u8,

    pub const json_field_names = .{
        .container_arguments = "ContainerArguments",
        .container_entrypoint = "ContainerEntrypoint",
        .environment = "Environment",
        .image_uri = "ImageUri",
        .post_analytics_processor_source_uri = "PostAnalyticsProcessorSourceUri",
        .problem_type = "ProblemType",
        .record_preprocessor_source_uri = "RecordPreprocessorSourceUri",
    };
};
