/// Settings that affect how the inference component caches data.
pub const InferenceComponentDataCacheConfig = struct {
    /// Sets whether the endpoint that hosts the inference component caches the
    /// model artifacts and container image.
    ///
    /// With caching enabled, the endpoint caches this data in each instance that it
    /// provisions for the inference component. That way, the inference component
    /// deploys faster during the auto scaling process. If caching isn't enabled,
    /// the inference component takes longer to deploy because of the time it spends
    /// downloading the data.
    enable_caching: bool,

    pub const json_field_names = .{
        .enable_caching = "EnableCaching",
    };
};
