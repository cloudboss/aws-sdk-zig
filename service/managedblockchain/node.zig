const aws = @import("aws");

const NodeFrameworkAttributes = @import("node_framework_attributes.zig").NodeFrameworkAttributes;
const NodeLogPublishingConfiguration = @import("node_log_publishing_configuration.zig").NodeLogPublishingConfiguration;
const StateDBType = @import("state_db_type.zig").StateDBType;
const NodeStatus = @import("node_status.zig").NodeStatus;

/// Configuration properties of a node.
pub const Node = struct {
    /// The Amazon Resource Name (ARN) of the node. For more information about ARNs
    /// and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8,

    /// The Availability Zone in which the node exists. Required for Ethereum nodes.
    availability_zone: ?[]const u8,

    /// The date and time that the node was created.
    creation_date: ?i64,

    /// Attributes of the blockchain framework being used.
    framework_attributes: ?NodeFrameworkAttributes,

    /// The unique identifier of the node.
    id: ?[]const u8,

    /// The instance type of the node.
    instance_type: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the customer managed key in Key Management
    /// Service (KMS) that the node uses for encryption at rest. If the value of
    /// this parameter is `"AWS Owned KMS Key"`, the node uses an Amazon Web
    /// Services owned KMS key for encryption. The node inherits this parameter from
    /// the member that it belongs to.
    ///
    /// For more information, see [Encryption at
    /// Rest](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/managed-blockchain-encryption-at-rest.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    ///
    /// Applies only to Hyperledger Fabric.
    kms_key_arn: ?[]const u8,

    /// Configuration properties for logging events associated with a peer node on a
    /// Hyperledger Fabric network on Managed Blockchain.
    log_publishing_configuration: ?NodeLogPublishingConfiguration,

    /// The unique identifier of the member to which the node belongs.
    ///
    /// Applies only to Hyperledger Fabric.
    member_id: ?[]const u8,

    /// The unique identifier of the network that the node is on.
    network_id: ?[]const u8,

    /// The state database that the node uses. Values are `LevelDB` or `CouchDB`.
    ///
    /// Applies only to Hyperledger Fabric.
    state_db: ?StateDBType,

    /// The status of the node.
    ///
    /// * `CREATING` - The Amazon Web Services account is in the process of creating
    ///   a node.
    ///
    /// * `AVAILABLE` - The node has been created and can participate in the
    ///   network.
    ///
    /// * `UNHEALTHY` - The node is impaired and might not function as expected.
    ///   Amazon Managed Blockchain automatically finds nodes in this state and
    ///   tries to recover them. If a node is recoverable, it returns to
    ///   `AVAILABLE`. Otherwise, it moves to `FAILED` status.
    ///
    /// * `CREATE_FAILED` - The Amazon Web Services account attempted to create a
    ///   node and creation failed.
    ///
    /// * `UPDATING` - The node is in the process of being updated.
    ///
    /// * `DELETING` - The node is in the process of being deleted.
    ///
    /// * `DELETED` - The node can no longer participate on the network.
    ///
    /// * `FAILED` - The node is no longer functional, cannot be recovered, and must
    ///   be deleted.
    ///
    /// * `INACCESSIBLE_ENCRYPTION_KEY` - The node is impaired and might not
    ///   function as expected because it cannot access the specified customer
    ///   managed key in KMS for encryption at rest. Either the KMS key was disabled
    ///   or deleted, or the grants on the key were revoked.
    ///
    /// The effect of disabling or deleting a key or of revoking a grant isn't
    /// immediate. It might take some time for the node resource to discover that
    /// the key is inaccessible. When a resource is in this state, we recommend
    /// deleting and recreating the resource.
    status: ?NodeStatus,

    /// Tags assigned to the node. Each tag consists of a key and optional value.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .creation_date = "CreationDate",
        .framework_attributes = "FrameworkAttributes",
        .id = "Id",
        .instance_type = "InstanceType",
        .kms_key_arn = "KmsKeyArn",
        .log_publishing_configuration = "LogPublishingConfiguration",
        .member_id = "MemberId",
        .network_id = "NetworkId",
        .state_db = "StateDB",
        .status = "Status",
        .tags = "Tags",
    };
};
