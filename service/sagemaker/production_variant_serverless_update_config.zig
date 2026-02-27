/// Specifies the serverless update concurrency configuration for an endpoint
/// variant.
pub const ProductionVariantServerlessUpdateConfig = struct {
    /// The updated maximum number of concurrent invocations your serverless
    /// endpoint can process.
    max_concurrency: ?i32,

    /// The updated amount of provisioned concurrency to allocate for the serverless
    /// endpoint. Should be less than or equal to `MaxConcurrency`.
    provisioned_concurrency: ?i32,

    pub const json_field_names = .{
        .max_concurrency = "MaxConcurrency",
        .provisioned_concurrency = "ProvisionedConcurrency",
    };
};
