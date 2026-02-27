const aws = @import("aws");

const MemberFrameworkAttributes = @import("member_framework_attributes.zig").MemberFrameworkAttributes;
const MemberLogPublishingConfiguration = @import("member_log_publishing_configuration.zig").MemberLogPublishingConfiguration;
const MemberStatus = @import("member_status.zig").MemberStatus;

/// Member configuration properties.
///
/// Applies only to Hyperledger Fabric.
pub const Member = struct {
    /// The Amazon Resource Name (ARN) of the member. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The date and time that the member was created.
    creation_date: ?i64,

    /// An optional description for the member.
    description: ?[]const u8,

    /// Attributes relevant to a member for the blockchain framework that the
    /// Managed Blockchain network uses.
    framework_attributes: ?MemberFrameworkAttributes,

    /// The unique identifier of the member.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the customer managed key in Key Management
    /// Service (KMS) that the member uses for encryption at rest. If the value of
    /// this parameter is `"AWS Owned KMS Key"`, the member uses an Amazon Web
    /// Services owned KMS key for encryption. This parameter is inherited by the
    /// nodes that this member owns.
    ///
    /// For more information, see [Encryption at
    /// Rest](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/managed-blockchain-encryption-at-rest.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    kms_key_arn: ?[]const u8,

    /// Configuration properties for logging events associated with a member.
    log_publishing_configuration: ?MemberLogPublishingConfiguration,

    /// The name of the member.
    name: ?[]const u8,

    /// The unique identifier of the network to which the member belongs.
    network_id: ?[]const u8,

    /// The status of a member.
    ///
    /// * `CREATING` - The Amazon Web Services account is in the process of creating
    ///   a member.
    ///
    /// * `AVAILABLE` - The member has been created and can participate in the
    ///   network.
    ///
    /// * `CREATE_FAILED` - The Amazon Web Services account attempted to create a
    ///   member and creation failed.
    ///
    /// * `UPDATING` - The member is in the process of being updated.
    ///
    /// * `DELETING` - The member and all associated resources are in the process of
    ///   being deleted. Either the Amazon Web Services account that owns the member
    ///   deleted it, or the member is being deleted as the result of an `APPROVED`
    /// `PROPOSAL` to remove the member.
    ///
    /// * `DELETED` - The member can no longer participate on the network and all
    ///   associated resources are deleted. Either the Amazon Web Services account
    ///   that owns the member deleted it, or the member is being deleted as the
    ///   result of an `APPROVED`
    /// `PROPOSAL` to remove the member.
    ///
    /// * `INACCESSIBLE_ENCRYPTION_KEY` - The member is impaired and might not
    ///   function as expected because it cannot access the specified customer
    ///   managed key in KMS for encryption at rest. Either the KMS key was disabled
    ///   or deleted, or the grants on the key were revoked.
    ///
    /// The effect of disabling or deleting a key or of revoking a grant isn't
    /// immediate. It might take some time for the member resource to discover that
    /// the key is inaccessible. When a resource is in this state, we recommend
    /// deleting and recreating the resource.
    status: ?MemberStatus,

    /// Tags assigned to the member. Tags consist of a key and optional value.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .framework_attributes = "FrameworkAttributes",
        .id = "Id",
        .kms_key_arn = "KmsKeyArn",
        .log_publishing_configuration = "LogPublishingConfiguration",
        .name = "Name",
        .network_id = "NetworkId",
        .status = "Status",
        .tags = "Tags",
    };
};
