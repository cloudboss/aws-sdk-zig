/// A list of environment parameters suggested by the Amazon SageMaker Inference
/// Recommender.
pub const EnvironmentParameter = struct {
    /// The environment key suggested by the Amazon SageMaker Inference Recommender.
    key: []const u8,

    /// The value suggested by the Amazon SageMaker Inference Recommender.
    value: []const u8,

    /// The value type suggested by the Amazon SageMaker Inference Recommender.
    value_type: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
        .value_type = "ValueType",
    };
};
