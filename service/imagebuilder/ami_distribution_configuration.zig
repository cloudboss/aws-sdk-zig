const aws = @import("aws");

const LaunchPermissionConfiguration = @import("launch_permission_configuration.zig").LaunchPermissionConfiguration;

/// Define and configure the output AMIs of the pipeline.
pub const AmiDistributionConfiguration = struct {
    /// The tags to apply to AMIs distributed to this Region.
    ami_tags: ?[]const aws.map.StringMapEntry,

    /// The description of the AMI distribution configuration. Minimum and maximum
    /// length are
    /// in characters.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the KMS key used to
    /// encrypt the distributed image.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8,

    /// Launch permissions can be used to configure which Amazon Web Services
    /// accounts can use the AMI to
    /// launch instances.
    launch_permission: ?LaunchPermissionConfiguration,

    /// The name of the output AMI.
    name: ?[]const u8,

    /// The ID of an account to which you want to distribute an image.
    target_account_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .ami_tags = "amiTags",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .launch_permission = "launchPermission",
        .name = "name",
        .target_account_ids = "targetAccountIds",
    };
};
