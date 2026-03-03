const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;

/// Writes the MIME content of the email to an S3 bucket.
pub const S3Action = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the specified the bucket has
    /// been deleted.
    action_failure_policy: ?ActionFailurePolicy = null,

    /// The Amazon Resource Name (ARN) of the IAM Role to use while writing to S3.
    /// This role must have access to the s3:PutObject, kms:Encrypt, and
    /// kms:GenerateDataKey APIs for the given bucket.
    role_arn: []const u8,

    /// The bucket name of the S3 bucket to write to.
    s3_bucket: []const u8,

    /// The S3 prefix to use for the write to the s3 bucket.
    s3_prefix: ?[]const u8 = null,

    /// The KMS Key ID to use to encrypt the message in S3.
    s3_sse_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .role_arn = "RoleArn",
        .s3_bucket = "S3Bucket",
        .s3_prefix = "S3Prefix",
        .s3_sse_kms_key_id = "S3SseKmsKeyId",
    };
};
