const aws = @import("aws");

const MemberFrameworkConfiguration = @import("member_framework_configuration.zig").MemberFrameworkConfiguration;
const MemberLogPublishingConfiguration = @import("member_log_publishing_configuration.zig").MemberLogPublishingConfiguration;

/// Configuration properties of the member.
///
/// Applies only to Hyperledger Fabric.
pub const MemberConfiguration = struct {
    /// An optional description of the member.
    description: ?[]const u8,

    /// Configuration properties of the blockchain framework relevant to the member.
    framework_configuration: MemberFrameworkConfiguration,

    /// The Amazon Resource Name (ARN) of the customer managed key in Key Management
    /// Service (KMS) to use for encryption at rest in the member. This parameter is
    /// inherited by any nodes that this member creates. For more information, see
    /// [Encryption at
    /// Rest](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/managed-blockchain-encryption-at-rest.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    ///
    /// Use one of the following options to specify this parameter:
    ///
    /// * **Undefined or empty string** - By default, use an KMS key that is owned
    ///   and managed by Amazon Web Services on your behalf.
    ///
    /// * **A valid symmetric customer managed KMS key** - Use the specified KMS key
    ///   in your account that you create, own, and manage.
    ///
    /// Amazon Managed Blockchain doesn't support asymmetric keys. For more
    /// information, see [Using symmetric and asymmetric
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html) in the *Key Management Service Developer Guide*.
    ///
    /// The following is an example of a KMS key ARN:
    /// `arn:aws:kms:us-east-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`
    kms_key_arn: ?[]const u8,

    /// Configuration properties for logging events associated with a member of a
    /// Managed Blockchain network.
    log_publishing_configuration: ?MemberLogPublishingConfiguration,

    /// The name of the member.
    name: []const u8,

    /// Tags assigned to the member. Tags consist of a key and optional value.
    ///
    /// When specifying tags during creation, you can specify multiple key-value
    /// pairs in a single request, with an overall maximum of 50 tags added to each
    /// resource.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "Description",
        .framework_configuration = "FrameworkConfiguration",
        .kms_key_arn = "KmsKeyArn",
        .log_publishing_configuration = "LogPublishingConfiguration",
        .name = "Name",
        .tags = "Tags",
    };
};
