const PostLaunchActionsDeploymentType = @import("post_launch_actions_deployment_type.zig").PostLaunchActionsDeploymentType;
const SsmDocument = @import("ssm_document.zig").SsmDocument;

/// Post Launch Actions to executed on the Test or Cutover instance.
pub const PostLaunchActions = struct {
    /// AWS Systems Manager Command's CloudWatch log group name.
    cloud_watch_log_group_name: ?[]const u8,

    /// Deployment type in which AWS Systems Manager Documents will be executed.
    deployment: ?PostLaunchActionsDeploymentType,

    /// AWS Systems Manager Command's logs S3 log bucket.
    s_3_log_bucket: ?[]const u8,

    /// AWS Systems Manager Command's logs S3 output key prefix.
    s_3_output_key_prefix: ?[]const u8,

    /// AWS Systems Manager Documents.
    ssm_documents: ?[]const SsmDocument,

    pub const json_field_names = .{
        .cloud_watch_log_group_name = "cloudWatchLogGroupName",
        .deployment = "deployment",
        .s_3_log_bucket = "s3LogBucket",
        .s_3_output_key_prefix = "s3OutputKeyPrefix",
        .ssm_documents = "ssmDocuments",
    };
};
