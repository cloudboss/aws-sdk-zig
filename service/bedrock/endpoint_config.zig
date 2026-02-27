const SageMakerEndpoint = @import("sage_maker_endpoint.zig").SageMakerEndpoint;

/// Specifies the configuration for the endpoint.
pub const EndpointConfig = union(enum) {
    /// The configuration specific to Amazon SageMaker for the endpoint.
    sage_maker: ?SageMakerEndpoint,

    pub const json_field_names = .{
        .sage_maker = "sageMaker",
    };
};
