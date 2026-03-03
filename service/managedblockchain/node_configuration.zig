const NodeLogPublishingConfiguration = @import("node_log_publishing_configuration.zig").NodeLogPublishingConfiguration;
const StateDBType = @import("state_db_type.zig").StateDBType;

/// Configuration properties of a node.
pub const NodeConfiguration = struct {
    /// The Availability Zone in which the node exists. Required for Ethereum nodes.
    availability_zone: ?[]const u8 = null,

    /// The Amazon Managed Blockchain instance type for the node.
    instance_type: []const u8,

    /// Configuration properties for logging events associated with a peer node on a
    /// Hyperledger Fabric network on Managed Blockchain.
    log_publishing_configuration: ?NodeLogPublishingConfiguration = null,

    /// The state database that the node uses. Values are `LevelDB` or `CouchDB`.
    /// When using an Amazon Managed Blockchain network with Hyperledger Fabric
    /// version 1.4 or later, the default is `CouchDB`.
    ///
    /// Applies only to Hyperledger Fabric.
    state_db: ?StateDBType = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .instance_type = "InstanceType",
        .log_publishing_configuration = "LogPublishingConfiguration",
        .state_db = "StateDB",
    };
};
