/// Container image configuration object for the monitoring job.
pub const MonitoringAppSpecification = struct {
    /// An array of arguments for the container used to run the monitoring job.
    container_arguments: ?[]const []const u8 = null,

    /// Specifies the entrypoint for a container used to run the monitoring job.
    container_entrypoint: ?[]const []const u8 = null,

    /// The container image to be run by the monitoring job.
    image_uri: []const u8,

    /// An Amazon S3 URI to a script that is called after analysis has been
    /// performed. Applicable only for the built-in (first party) containers.
    post_analytics_processor_source_uri: ?[]const u8 = null,

    /// An Amazon S3 URI to a script that is called per row prior to running
    /// analysis. It can base64 decode the payload and convert it into a flattened
    /// JSON so that the built-in container can use the converted data. Applicable
    /// only for the built-in (first party) containers.
    record_preprocessor_source_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_arguments = "ContainerArguments",
        .container_entrypoint = "ContainerEntrypoint",
        .image_uri = "ImageUri",
        .post_analytics_processor_source_uri = "PostAnalyticsProcessorSourceUri",
        .record_preprocessor_source_uri = "RecordPreprocessorSourceUri",
    };
};
