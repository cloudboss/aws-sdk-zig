/// Specifies the serverless configuration for an endpoint variant.
pub const ProductionVariantServerlessConfig = struct {
    /// The maximum number of concurrent invocations your serverless endpoint can
    /// process.
    max_concurrency: i32,

    /// The memory size of your serverless endpoint. Valid values are in 1 GB
    /// increments: 1024 MB, 2048 MB, 3072 MB, 4096 MB, 5120 MB, or 6144 MB.
    memory_size_in_mb: i32,

    /// The amount of provisioned concurrency to allocate for the serverless
    /// endpoint. Should be less than or equal to `MaxConcurrency`.
    ///
    /// This field is not supported for serverless endpoint recommendations for
    /// Inference Recommender jobs. For more information about creating an Inference
    /// Recommender job, see
    /// [CreateInferenceRecommendationsJobs](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateInferenceRecommendationsJob.html).
    provisioned_concurrency: ?i32 = null,

    pub const json_field_names = .{
        .max_concurrency = "MaxConcurrency",
        .memory_size_in_mb = "MemorySizeInMB",
        .provisioned_concurrency = "ProvisionedConcurrency",
    };
};
