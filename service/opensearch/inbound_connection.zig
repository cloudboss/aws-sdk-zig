const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const InboundConnectionStatus = @import("inbound_connection_status.zig").InboundConnectionStatus;
const DomainInformationContainer = @import("domain_information_container.zig").DomainInformationContainer;

/// Describes an inbound cross-cluster connection for Amazon OpenSearch Service.
/// For more
/// information, see [Cross-cluster search
/// for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cross-cluster-search.html).
pub const InboundConnection = struct {
    /// The unique identifier of the connection.
    connection_id: ?[]const u8,

    /// The connection mode.
    connection_mode: ?ConnectionMode,

    /// The current status of the connection.
    connection_status: ?InboundConnectionStatus,

    /// Information about the source (local) domain.
    local_domain_info: ?DomainInformationContainer,

    /// Information about the destination (remote) domain.
    remote_domain_info: ?DomainInformationContainer,

    pub const json_field_names = .{
        .connection_id = "ConnectionId",
        .connection_mode = "ConnectionMode",
        .connection_status = "ConnectionStatus",
        .local_domain_info = "LocalDomainInfo",
        .remote_domain_info = "RemoteDomainInfo",
    };
};
