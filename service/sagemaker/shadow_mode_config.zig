const ShadowModelVariantConfig = @import("shadow_model_variant_config.zig").ShadowModelVariantConfig;

/// The configuration of `ShadowMode` inference experiment type, which specifies
/// a production variant to take all the inference requests, and a shadow
/// variant to which Amazon SageMaker replicates a percentage of the inference
/// requests. For the shadow variant it also specifies the percentage of
/// requests that Amazon SageMaker replicates.
pub const ShadowModeConfig = struct {
    /// List of shadow variant configurations.
    shadow_model_variants: []const ShadowModelVariantConfig,

    /// The name of the production variant, which takes all the inference requests.
    source_model_variant_name: []const u8,

    pub const json_field_names = .{
        .shadow_model_variants = "ShadowModelVariants",
        .source_model_variant_name = "SourceModelVariantName",
    };
};
