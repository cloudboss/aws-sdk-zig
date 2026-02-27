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
        .sensitive_data_s3_object_multiple = "SensitiveData_S3Object_Multiple",
        .sensitive_data_s3_object_financial = "SensitiveData_S3Object_Financial",
        .sensitive_data_s3_object_personal = "SensitiveData_S3Object_Personal",
        .sensitive_data_s3_object_credentials = "SensitiveData_S3Object_Credentials",
        .sensitive_data_s3_object_custom_identifier = "SensitiveData_S3Object_CustomIdentifier",
        .policy_iam_user_s3_bucket_public = "Policy_IAMUser_S3BucketPublic",
        .policy_iam_user_s3_bucket_shared_externally = "Policy_IAMUser_S3BucketSharedExternally",
        .policy_iam_user_s3_bucket_replicated_externally = "Policy_IAMUser_S3BucketReplicatedExternally",
        .policy_iam_user_s3_bucket_encryption_disabled = "Policy_IAMUser_S3BucketEncryptionDisabled",
        .policy_iam_user_s3_block_public_access_disabled = "Policy_IAMUser_S3BlockPublicAccessDisabled",
        .policy_iam_user_s3_bucket_shared_with_cloud_front = "Policy_IAMUser_S3BucketSharedWithCloudFront",
    };
};
