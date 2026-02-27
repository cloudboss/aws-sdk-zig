const TrainedModelArtifactMaxSizeUnitType = @import("trained_model_artifact_max_size_unit_type.zig").TrainedModelArtifactMaxSizeUnitType;

/// Specifies the maximum size limit for trained model artifacts. This
/// configuration helps control storage costs and ensures that trained models
/// don't exceed specified size constraints. The size limit applies to the total
/// size of all artifacts produced by the training job.
pub const TrainedModelArtifactMaxSize = struct {
    /// The unit of measurement for the maximum artifact size. Valid values include
    /// common storage units such as bytes, kilobytes, megabytes, gigabytes, and
    /// terabytes.
    unit: TrainedModelArtifactMaxSizeUnitType,

    /// The numerical value for the maximum artifact size limit. This value is
    /// interpreted according to the specified unit.
    value: f64,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
