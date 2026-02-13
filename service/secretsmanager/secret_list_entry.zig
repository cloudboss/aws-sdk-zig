const aws = @import("aws");

const ExternalSecretRotationMetadataItem = @import("external_secret_rotation_metadata_item.zig").ExternalSecretRotationMetadataItem;
const RotationRulesType = @import("rotation_rules_type.zig").RotationRulesType;
const Tag = @import("tag.zig").Tag;

/// A structure that contains the details about a secret. It does not include
/// the
/// encrypted `SecretString` and `SecretBinary` values. To get those
/// values, use
/// [GetSecretValue](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html) .
pub const SecretListEntry = struct {
    /// The Amazon Resource Name (ARN) of the secret.
    arn: ?[]const u8,

    /// The date and time when a secret was created.
    created_date: ?i64,

    /// The date and time the deletion of the secret occurred. Not present on active
    /// secrets.
    /// The secret can be recovered until the number of days in the recovery window
    /// has passed,
    /// as specified in the `RecoveryWindowInDays` parameter of the [
    /// `DeleteSecret`
    /// ](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_DeleteSecret.html) operation.
    deleted_date: ?i64,

    /// The user-provided description of the secret.
    description: ?[]const u8,

    /// The metadata needed to successfully rotate a managed external secret. A list
    /// of key
    /// value pairs in JSON format specified by the partner. For more information
    /// about the
    /// required information, see [Managed external secrets
    /// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
    external_secret_rotation_metadata: ?[]const ExternalSecretRotationMetadataItem,

    /// The role that Secrets Manager assumes to call APIs required to perform the
    /// rotation. For more
    /// information about the required information, see [Managed
    /// external secrets
    /// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
    external_secret_rotation_role_arn: ?[]const u8,

    /// The ARN of the KMS key that Secrets Manager uses to encrypt the secret
    /// value. If the secret is
    /// encrypted with the Amazon Web Services managed key `aws/secretsmanager`,
    /// this
    /// field is omitted.
    kms_key_id: ?[]const u8,

    /// The date that the secret was last accessed in the Region. This field is
    /// omitted if the
    /// secret has never been retrieved in the Region.
    last_accessed_date: ?i64,

    /// The last date and time that this secret was modified in any way.
    last_changed_date: ?i64,

    /// The most recent date and time that the Secrets Manager rotation process was
    /// successfully completed. This value is null if the secret hasn't ever
    /// rotated.
    last_rotated_date: ?i64,

    /// The friendly name of the secret.
    name: ?[]const u8,

    /// The next rotation is scheduled to occur on or before this date. If the
    /// secret isn't
    /// configured for rotation or rotation has been disabled, Secrets Manager
    /// returns null.
    next_rotation_date: ?i64,

    /// Returns the name of the service that created the secret.
    owning_service: ?[]const u8,

    /// The Region where Secrets Manager originated the secret.
    primary_region: ?[]const u8,

    /// Indicates whether automatic, scheduled rotation is enabled for this secret.
    rotation_enabled: ?bool,

    /// The ARN of an Amazon Web Services Lambda function invoked by Secrets Manager
    /// to rotate and expire the secret
    /// either automatically per the schedule or manually by a call to [
    /// `RotateSecret`
    /// ](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_RotateSecret.html).
    rotation_lambda_arn: ?[]const u8,

    /// A structure that defines the rotation configuration for the secret.
    rotation_rules: ?RotationRulesType,

    /// A list of all of the currently assigned `SecretVersionStage` staging labels
    /// and the `SecretVersionId` attached to each one. Staging labels are used to
    /// keep track of the different versions during the rotation process.
    ///
    /// **Note:**
    ///
    /// A version that does not have any `SecretVersionStage` is considered
    /// deprecated and subject to deletion. Such versions are not included in this
    /// list.
    secret_versions_to_stages: ?[]const aws.map.MapEntry([]const []const u8),

    /// The list of user-defined tags associated with the secret. To add tags to a
    /// secret, use
    /// [
    /// `TagResource`
    /// ](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_TagResource.html). To remove tags, use [
    /// `UntagResource`
    /// ](https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_UntagResource.html).
    tags: ?[]const Tag,

    /// The exact string that identifies the third-party partner that holds the
    /// external
    /// secret. For more information, see [Managed external secret
    /// partners](https://docs.aws.amazon.com/secretsmanager/latest/userguide/mes-partners.html).
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .created_date = "CreatedDate",
        .deleted_date = "DeletedDate",
        .description = "Description",
        .external_secret_rotation_metadata = "ExternalSecretRotationMetadata",
        .external_secret_rotation_role_arn = "ExternalSecretRotationRoleArn",
        .kms_key_id = "KmsKeyId",
        .last_accessed_date = "LastAccessedDate",
        .last_changed_date = "LastChangedDate",
        .last_rotated_date = "LastRotatedDate",
        .name = "Name",
        .next_rotation_date = "NextRotationDate",
        .owning_service = "OwningService",
        .primary_region = "PrimaryRegion",
        .rotation_enabled = "RotationEnabled",
        .rotation_lambda_arn = "RotationLambdaARN",
        .rotation_rules = "RotationRules",
        .secret_versions_to_stages = "SecretVersionsToStages",
        .tags = "Tags",
        .@"type" = "Type",
    };
};
