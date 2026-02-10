/// **Note:**
///
/// Amazon Elastic Graphics reached end of life on January 8, 2024.
///
/// Describes the association between an instance and an Elastic Graphics
/// accelerator.
pub const ElasticGpuAssociation = struct {
    /// The ID of the association.
    elastic_gpu_association_id: ?[]const u8,

    /// The state of the association between the instance and the
    /// Elastic Graphics accelerator.
    elastic_gpu_association_state: ?[]const u8,

    /// The time the Elastic Graphics accelerator was associated with the instance.
    elastic_gpu_association_time: ?[]const u8,

    /// The ID of the Elastic Graphics accelerator.
    elastic_gpu_id: ?[]const u8,
};
