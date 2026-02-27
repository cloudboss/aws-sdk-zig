/// The name and sampling percentage of a shadow variant.
pub const ShadowModelVariantConfig = struct {
    /// The percentage of inference requests that Amazon SageMaker replicates from
    /// the production variant to the shadow variant.
    sampling_percentage: i32,

    /// The name of the shadow variant.
    shadow_model_variant_name: []const u8,

    pub const json_field_names = .{
        .sampling_percentage = "SamplingPercentage",
        .shadow_model_variant_name = "ShadowModelVariantName",
    };
};
