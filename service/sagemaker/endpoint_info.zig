/// Details about a customer endpoint that was compared in an Inference
/// Recommender job.
pub const EndpointInfo = struct {
    /// The name of a customer's endpoint.
    endpoint_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_name = "EndpointName",
    };
};
