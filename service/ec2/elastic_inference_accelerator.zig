/// Amazon Elastic Inference is no longer available.
///
/// Describes an elastic inference accelerator.
pub const ElasticInferenceAccelerator = struct {
    /// The number of elastic inference accelerators to attach to the instance.
    ///
    /// Default: 1
    count: ?i32,

    /// The type of elastic inference accelerator. The possible values are
    /// `eia1.medium`, `eia1.large`, `eia1.xlarge`, `eia2.medium`, `eia2.large`, and
    /// `eia2.xlarge`.
    @"type": []const u8,
};
