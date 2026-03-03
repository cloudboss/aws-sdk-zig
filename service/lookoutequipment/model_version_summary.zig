const ModelQuality = @import("model_quality.zig").ModelQuality;
const ModelVersionSourceType = @import("model_version_source_type.zig").ModelVersionSourceType;
const ModelVersionStatus = @import("model_version_status.zig").ModelVersionStatus;

/// Contains information about the specific model version.
pub const ModelVersionSummary = struct {
    /// The time when this model version was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model that this model version is a
    /// version
    /// of.
    model_arn: ?[]const u8 = null,

    /// The name of the model that this model version is a version of.
    model_name: ?[]const u8 = null,

    /// Provides a quality assessment for a model that uses labels. If Lookout for
    /// Equipment determines that the
    /// model quality is poor based on training metrics, the value is
    /// `POOR_QUALITY_DETECTED`. Otherwise, the value is
    /// `QUALITY_THRESHOLD_MET`.
    ///
    /// If the model is unlabeled, the model quality can't
    /// be assessed and the value of `ModelQuality` is
    /// `CANNOT_DETERMINE_QUALITY`. In this situation, you can get a model quality
    /// assessment by adding labels to the input dataset and retraining the model.
    ///
    /// For information about improving the quality of a model, see [Best practices
    /// with
    /// Amazon Lookout for
    /// Equipment](https://docs.aws.amazon.com/lookout-for-equipment/latest/ug/best-practices.html).
    model_quality: ?ModelQuality = null,

    /// The version of the model.
    model_version: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the model version.
    model_version_arn: ?[]const u8 = null,

    /// Indicates how this model version was generated.
    source_type: ?ModelVersionSourceType = null,

    /// The current status of the model version.
    status: ?ModelVersionStatus = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .model_arn = "ModelArn",
        .model_name = "ModelName",
        .model_quality = "ModelQuality",
        .model_version = "ModelVersion",
        .model_version_arn = "ModelVersionArn",
        .source_type = "SourceType",
        .status = "Status",
    };
};
