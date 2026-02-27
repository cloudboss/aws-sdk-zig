const NodeFabricLogPublishingConfiguration = @import("node_fabric_log_publishing_configuration.zig").NodeFabricLogPublishingConfiguration;

/// Configuration properties for logging events associated with a peer node on a
/// Hyperledger Fabric network on Managed Blockchain.
pub const NodeLogPublishingConfiguration = struct {
    /// Configuration properties for logging events associated with a node that is
    /// owned by a member of a Managed Blockchain network using the Hyperledger
    /// Fabric framework.
    fabric: ?NodeFabricLogPublishingConfiguration,

    pub const json_field_names = .{
        .fabric = "Fabric",
    };
};
