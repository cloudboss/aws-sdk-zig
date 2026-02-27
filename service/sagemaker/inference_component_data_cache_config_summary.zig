/// Settings that affect how the inference component caches data.
pub const InferenceComponentDataCacheConfigSummary = struct {
    /// Indicates whether the inference component caches model artifacts as part of
    /// the auto scaling process.
    enable_caching: bool,

    pub const json_field_names = .{
        .enable_caching = "EnableCaching",
    };
};
