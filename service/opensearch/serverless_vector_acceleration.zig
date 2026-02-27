/// Configuration for serverless vector acceleration, which provides
/// [GPU-accelerated](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/gpu-acceleration-vector-index.html) vector
/// search capabilities for improved performance on vector workloads.
pub const ServerlessVectorAcceleration = struct {
    /// Specifies whether serverless vector acceleration is enabled for the domain.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
