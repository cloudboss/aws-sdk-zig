const LogConfigurations = @import("log_configurations.zig").LogConfigurations;

/// Configuration properties for logging events associated with a peer node
/// owned by a member in a Managed Blockchain network.
pub const NodeFabricLogPublishingConfiguration = struct {
    /// Configuration properties for logging events associated with chaincode
    /// execution on a peer node. Chaincode logs contain the results of
    /// instantiating, invoking, and querying the chaincode. A peer can run multiple
    /// instances of chaincode. When enabled, a log stream is created for all
    /// chaincodes, with an individual log stream for each chaincode.
    chaincode_logs: ?LogConfigurations = null,

    /// Configuration properties for a peer node log. Peer node logs contain
    /// messages generated when your client submits transaction proposals to peer
    /// nodes, requests to join channels, enrolls an admin peer, and lists the
    /// chaincode instances on a peer node.
    peer_logs: ?LogConfigurations = null,

    pub const json_field_names = .{
        .chaincode_logs = "ChaincodeLogs",
        .peer_logs = "PeerLogs",
    };
};
