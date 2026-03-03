/// An object representing the destination of a pipeline.
pub const PipelineDestination = struct {
    /// The endpoint receiving data from the pipeline.
    endpoint: ?[]const u8 = null,

    /// The name of the service receiving data from the pipeline.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .service_name = "ServiceName",
    };
};
