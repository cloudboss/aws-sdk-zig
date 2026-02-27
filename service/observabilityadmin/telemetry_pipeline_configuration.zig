/// Defines the configuration for a telemetry pipeline, including how data flows
/// from sources through processors to destinations.
pub const TelemetryPipelineConfiguration = struct {
    /// The pipeline configuration body that defines the data processing rules and
    /// transformations.
    body: []const u8,

    pub const json_field_names = .{
        .body = "Body",
    };
};
