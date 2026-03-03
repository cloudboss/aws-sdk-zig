const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The model deployment settings for the SageMaker Canvas application.
///
/// In order to enable model deployment for Canvas, the SageMaker Domain's or
/// user profile's Amazon Web Services IAM execution role must have the
/// `AmazonSageMakerCanvasDirectDeployAccess` policy attached. You can also turn
/// on model deployment permissions through the SageMaker Domain's or user
/// profile's settings in the SageMaker console.
pub const DirectDeploySettings = struct {
    /// Describes whether model deployment permissions are enabled or disabled in
    /// the Canvas application.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};
