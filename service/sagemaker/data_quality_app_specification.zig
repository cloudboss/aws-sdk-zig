const aws = @import("aws");

/// Information about the container that a data quality monitoring job runs.
pub const DataQualityAppSpecification = struct {
    /// The arguments to send to the container that the monitoring job runs.
    container_arguments: ?[]const []const u8,

    /// The entrypoint for a container used to run a monitoring job.
    container_entrypoint: ?[]const []const u8,

    /// Sets the environment variables in the container that the monitoring job
    /// runs.
    environment: ?[]const aws.map.StringMapEntry,

    /// The container image that the data quality monitoring job runs.
    image_uri: []const u8,

    /// An Amazon S3 URI to a script that is called after analysis has been
    /// performed. Applicable only for the built-in (first party) containers.
    post_analytics_processor_source_uri: ?[]const u8,

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
        .record_preprocessor_source_uri = "RecordPreprocessorSourceUri",
    };
};
