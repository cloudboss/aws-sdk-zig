const ModelCacheSetting = @import("model_cache_setting.zig").ModelCacheSetting;

/// Specifies additional configuration for hosting multi-model endpoints.
pub const MultiModelConfig = struct {
    /// Whether to cache models for a multi-model endpoint. By default, multi-model
    /// endpoints cache models so that a model does not have to be loaded into
    /// memory each time it is invoked. Some use cases do not benefit from model
    /// caching. For example, if an endpoint hosts a large number of models that are
    /// each invoked infrequently, the endpoint might perform better if you disable
    /// model caching. To disable model caching, set the value of this parameter to
    /// `Disabled`.
    model_cache_setting: ?ModelCacheSetting = null,

    pub const json_field_names = .{
        .model_cache_setting = "ModelCacheSetting",
    };
};
