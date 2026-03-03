/// The settings for encrypting data in transit.
pub const AwsMskClusterClusterInfoEncryptionInfoEncryptionInTransitDetails = struct {
    /// Indicates the encryption setting for data in transit between clients and
    /// brokers.
    client_broker: ?[]const u8 = null,

    /// When set to `true`, it indicates that data communication among the broker
    /// nodes of the cluster is
    /// encrypted. When set to `false`, the communication happens in plain text. The
    /// default value is
    /// `true`.
    in_cluster: ?bool = null,

    pub const json_field_names = .{
        .client_broker = "ClientBroker",
        .in_cluster = "InCluster",
    };
};
