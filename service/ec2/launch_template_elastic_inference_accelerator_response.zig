/// Amazon Elastic Inference is no longer available.
///
/// Describes an elastic inference accelerator.
pub const LaunchTemplateElasticInferenceAcceleratorResponse = struct {
    /// The number of elastic inference accelerators to attach to the instance.
    count: ?i32,

    /// The type of elastic inference accelerator. The possible values are
    /// eia1.medium,
    /// eia1.large, and eia1.xlarge.
    @"type": ?[]const u8,
};
