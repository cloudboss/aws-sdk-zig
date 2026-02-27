const ContentRedactionOutput = @import("content_redaction_output.zig").ContentRedactionOutput;

/// Allows you to specify additional settings for your Call Analytics post-call
/// request,
/// including output locations for your redacted transcript, which IAM role to
/// use,
/// and which encryption key to use.
///
/// `DataAccessRoleArn` and `OutputLocation` are required
/// fields.
///
/// `PostCallAnalyticsSettings` provides you with the same insights as a
/// Call Analytics post-call transcription. Refer to [Post-call
/// analytics](https://docs.aws.amazon.com/transcribe/latest/dg/tca-post-call.html) for more information
/// on this feature.
pub const PostCallAnalyticsSettings = struct {
    /// Specify whether you want only a redacted transcript or both a redacted and
    /// an unredacted
    /// transcript. If you choose redacted and unredacted, two JSON files are
    /// generated and stored in the
    /// Amazon S3 output location you specify.
    ///
    /// Note that to include `ContentRedactionOutput` in your request, you must
    /// enable content redaction (`ContentRedactionType`).
    content_redaction_output: ?ContentRedactionOutput,

    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files. If the role that
    /// you
    /// specify doesn’t have the appropriate permissions to access the specified
    /// Amazon S3
    /// location, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`. For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: []const u8,

    /// The KMS key you want to use to encrypt your Call Analytics post-call
    /// output.
    ///
    /// If using a key located in the **current**
    /// Amazon Web Services account, you can specify your KMS key in one of four
    /// ways:
    ///
    /// * Use the KMS key ID itself. For example,
    /// `1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use an alias for the KMS key ID. For example,
    /// `alias/ExampleAlias`.
    ///
    /// * Use the Amazon Resource Name (ARN) for the KMS key ID. For
    /// example,
    /// `arn:aws:kms:region:account-ID:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use the ARN for the KMS key alias. For example,
    /// `arn:aws:kms:region:account-ID:alias/ExampleAlias`.
    ///
    /// If using a key located in a **different**
    /// Amazon Web Services account than the current Amazon Web Services account,
    /// you can specify
    /// your KMS key in one of two ways:
    ///
    /// * Use the ARN for the KMS key ID. For example,
    /// `arn:aws:kms:region:account-ID:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Use the ARN for the KMS key alias. For example,
    /// `arn:aws:kms:region:account-ID:alias/ExampleAlias`.
    ///
    /// Note that the role making the
    /// request must have permission to use the specified KMS key.
    output_encryption_kms_key_id: ?[]const u8,

    /// The Amazon S3 location where you want your Call Analytics post-call
    /// transcription output stored. You can use any of the following formats to
    /// specify the output
    /// location:
    ///
    /// * s3://DOC-EXAMPLE-BUCKET
    ///
    /// * s3://DOC-EXAMPLE-BUCKET/my-output-folder/
    ///
    /// * s3://DOC-EXAMPLE-BUCKET/my-output-folder/my-call-analytics-job.json
    output_location: []const u8,

    pub const json_field_names = .{
        .content_redaction_output = "ContentRedactionOutput",
        .data_access_role_arn = "DataAccessRoleArn",
        .output_encryption_kms_key_id = "OutputEncryptionKMSKeyId",
        .output_location = "OutputLocation",
    };
};
