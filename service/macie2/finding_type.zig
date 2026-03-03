const std = @import("std");

/// The type of finding. For details about each type, see [Types of
/// findings](https://docs.aws.amazon.com/macie/latest/user/findings-types.html)
/// in the *Amazon Macie User Guide*. Possible values are:
pub const FindingType = enum {
    sensitive_data_s3_object_multiple,
    sensitive_data_s3_object_financial,
    sensitive_data_s3_object_personal,
    sensitive_data_s3_object_credentials,
    sensitive_data_s3_object_custom_identifier,
    policy_iam_user_s3_bucket_public,
    policy_iam_user_s3_bucket_shared_externally,
    policy_iam_user_s3_bucket_replicated_externally,
    policy_iam_user_s3_bucket_encryption_disabled,
    policy_iam_user_s3_block_public_access_disabled,
    policy_iam_user_s3_bucket_shared_with_cloud_front,

    pub const json_field_names = .{
        .sensitive_data_s3_object_multiple = "SensitiveData:S3Object/Multiple",
        .sensitive_data_s3_object_financial = "SensitiveData:S3Object/Financial",
        .sensitive_data_s3_object_personal = "SensitiveData:S3Object/Personal",
        .sensitive_data_s3_object_credentials = "SensitiveData:S3Object/Credentials",
        .sensitive_data_s3_object_custom_identifier = "SensitiveData:S3Object/CustomIdentifier",
        .policy_iam_user_s3_bucket_public = "Policy:IAMUser/S3BucketPublic",
        .policy_iam_user_s3_bucket_shared_externally = "Policy:IAMUser/S3BucketSharedExternally",
        .policy_iam_user_s3_bucket_replicated_externally = "Policy:IAMUser/S3BucketReplicatedExternally",
        .policy_iam_user_s3_bucket_encryption_disabled = "Policy:IAMUser/S3BucketEncryptionDisabled",
        .policy_iam_user_s3_block_public_access_disabled = "Policy:IAMUser/S3BlockPublicAccessDisabled",
        .policy_iam_user_s3_bucket_shared_with_cloud_front = "Policy:IAMUser/S3BucketSharedWithCloudFront",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sensitive_data_s3_object_multiple => "SensitiveData:S3Object/Multiple",
            .sensitive_data_s3_object_financial => "SensitiveData:S3Object/Financial",
            .sensitive_data_s3_object_personal => "SensitiveData:S3Object/Personal",
            .sensitive_data_s3_object_credentials => "SensitiveData:S3Object/Credentials",
            .sensitive_data_s3_object_custom_identifier => "SensitiveData:S3Object/CustomIdentifier",
            .policy_iam_user_s3_bucket_public => "Policy:IAMUser/S3BucketPublic",
            .policy_iam_user_s3_bucket_shared_externally => "Policy:IAMUser/S3BucketSharedExternally",
            .policy_iam_user_s3_bucket_replicated_externally => "Policy:IAMUser/S3BucketReplicatedExternally",
            .policy_iam_user_s3_bucket_encryption_disabled => "Policy:IAMUser/S3BucketEncryptionDisabled",
            .policy_iam_user_s3_block_public_access_disabled => "Policy:IAMUser/S3BlockPublicAccessDisabled",
            .policy_iam_user_s3_bucket_shared_with_cloud_front => "Policy:IAMUser/S3BucketSharedWithCloudFront",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
