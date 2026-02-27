const ServerlessVectorAccelerationStatus = @import("serverless_vector_acceleration_status.zig").ServerlessVectorAccelerationStatus;

/// Configuration options for vector search capabilities in an OpenSearch
/// Serverless collection.
pub const VectorOptions = struct {
    /// Specifies whether serverless vector acceleration is enabled for the
    /// collection.
    serverless_vector_acceleration: ServerlessVectorAccelerationStatus,

    pub const json_field_names = .{
        .serverless_vector_acceleration = "ServerlessVectorAcceleration",
    };
};
