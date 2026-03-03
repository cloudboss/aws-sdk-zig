/// Amazon Elastic Inference is no longer available.
///
/// Describes the association between an instance and an elastic inference
/// accelerator.
pub const ElasticInferenceAcceleratorAssociation = struct {
    /// The Amazon Resource Name (ARN) of the elastic inference accelerator.
    elastic_inference_accelerator_arn: ?[]const u8 = null,

    /// The ID of the association.
    elastic_inference_accelerator_association_id: ?[]const u8 = null,

    /// The state of the elastic inference accelerator.
    elastic_inference_accelerator_association_state: ?[]const u8 = null,

    /// The time at which the elastic inference accelerator is associated with an
    /// instance.
    elastic_inference_accelerator_association_time: ?i64 = null,
};
