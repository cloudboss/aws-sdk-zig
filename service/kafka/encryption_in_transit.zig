const ClientBroker = @import("client_broker.zig").ClientBroker;

/// The settings for encrypting data in transit.
pub const EncryptionInTransit = struct {
    /// Indicates the encryption setting for data in transit between clients and
    /// brokers. The following are the possible values.
    ///
    /// TLS means that client-broker communication is enabled with TLS only.
    ///
    /// TLS_PLAINTEXT means that client-broker communication is enabled for both
    /// TLS-encrypted, as well as plaintext data.
    ///
    /// PLAINTEXT means that client-broker communication is enabled in plaintext
    /// only.
    ///
    /// The default value is TLS_PLAINTEXT.
    client_broker: ?ClientBroker = null,

    /// When set to true, it indicates that data communication among the broker
    /// nodes of the cluster is encrypted. When set to false, the communication
    /// happens in plaintext.
    ///
    /// The default value is true.
    in_cluster: ?bool = null,

    pub const json_field_names = .{
        .client_broker = "ClientBroker",
        .in_cluster = "InCluster",
    };
};
