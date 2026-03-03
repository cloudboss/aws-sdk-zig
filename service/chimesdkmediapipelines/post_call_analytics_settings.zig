const ContentRedactionOutput = @import("content_redaction_output.zig").ContentRedactionOutput;

/// Allows you to specify additional settings for your Call Analytics post-call
/// request, including output locations for your redacted transcript, which IAM
/// role to use, and which encryption key to use.
///
/// `DataAccessRoleArn` and `OutputLocation` are required fields.
///
/// `PostCallAnalyticsSettings` provides the same insights as a Call Analytics
/// post-call transcription. For more information, refer to
/// [Post-call analytics with real-time
/// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-post-call.html) in the *Amazon Transcribe Developer Guide*.
pub const PostCallAnalyticsSettings = struct {
    /// The content redaction output settings for a post-call analysis task.
    content_redaction_output: ?ContentRedactionOutput = null,

    /// The ARN of the role used by Amazon Web Services Transcribe to upload your
    /// post call analysis. For more information, see
    /// [Post-call analytics with real-time
    /// transcriptions](https://docs.aws.amazon.com/transcribe/latest/dg/tca-post-call.html) in the *Amazon Transcribe Developer Guide*.
    data_access_role_arn: []const u8,

    /// The ID of the KMS (Key Management Service) key used to encrypt the output.
    output_encryption_kms_key_id: ?[]const u8 = null,

    /// The URL of the Amazon S3 bucket that contains the post-call data.
    output_location: []const u8,

    pub const json_field_names = .{
        .content_redaction_output = "ContentRedactionOutput",
        .data_access_role_arn = "DataAccessRoleArn",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .output_location = "OutputLocation",
    };
};
