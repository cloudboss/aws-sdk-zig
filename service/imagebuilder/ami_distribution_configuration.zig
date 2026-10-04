const aws = @import("aws");

const LaunchPermissionConfiguration = @import("launch_permission_configuration.zig").LaunchPermissionConfiguration;

/// Define and configure the output AMIs of the pipeline.
pub const AmiDistributionConfiguration = struct {
    /// The tags to apply to AMIs distributed to this Region.
    ami_tags: ?[]const aws.map.StringMapEntry = null,

    /// The description to apply to the distributed AMI. Image Builder sets this as
    /// the
    /// output AMI's description in each target Region and account. If you
    /// don't specify a description, the AMI in the build Region uses the
    /// image recipe's description, if the recipe has one. Copies distributed
    /// to other Regions and accounts don't receive a default
    /// description.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that uniquely identifies the KMS key used to
    /// encrypt the distributed image.
    /// This can be either the Key ARN or the Alias ARN. For more information, see
    /// [Key identifiers
    /// (KeyId)](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#key-id-key-ARN)
    /// in the *Key Management Service Developer Guide*.
    kms_key_id: ?[]const u8 = null,

    /// Launch permissions can be used to configure which Amazon Web Services
    /// accounts can use the AMI to
    /// launch instances.
    launch_permission: ?LaunchPermissionConfiguration = null,

    /// The name of the output AMI. The name must include the
    /// `{{ imagebuilder:buildDate }}` dynamic tag so that each build
    /// produces a uniquely named AMI. If you don't specify a name, Image Builder
    /// names the output AMI with the image name followed by the build timestamp,
    /// for example `my-image 2022-10-26T22-30-05.912619Z`.
    name: ?[]const u8 = null,

    /// The Amazon Web Services account IDs to distribute the AMI to in this Region.
    /// Each listed
    /// account receives its own copy of the output AMI. If you don't specify
    /// accounts, Image Builder distributes the AMI only to your own account.
    target_account_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ami_tags = "amiTags",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .launch_permission = "launchPermission",
        .name = "name",
        .target_account_ids = "targetAccountIds",
    };
};
