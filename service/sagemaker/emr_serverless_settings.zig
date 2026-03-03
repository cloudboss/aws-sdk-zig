const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The settings for running Amazon EMR Serverless jobs in SageMaker Canvas.
pub const EmrServerlessSettings = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Web Services IAM role that is
    /// assumed for running Amazon EMR Serverless jobs in SageMaker Canvas. This
    /// role should have the necessary permissions to read and write data attached
    /// and a trust relationship with EMR Serverless.
    execution_role_arn: ?[]const u8 = null,

    /// Describes whether Amazon EMR Serverless job capabilities are enabled or
    /// disabled in the SageMaker Canvas application.
    status: ?FeatureStatus = null,

    pub const json_field_names = .{
        .execution_role_arn = "ExecutionRoleArn",
        .status = "Status",
    };
};
