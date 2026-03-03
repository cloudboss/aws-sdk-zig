const ConnectionMode = @import("connection_mode.zig").ConnectionMode;
const ConnectionProperties = @import("connection_properties.zig").ConnectionProperties;
const OutboundConnectionStatus = @import("outbound_connection_status.zig").OutboundConnectionStatus;
const DomainInformationContainer = @import("domain_information_container.zig").DomainInformationContainer;

/// Specifies details about an outbound cross-cluster connection.
pub const OutboundConnection = struct {
    /// Name of the connection.
    connection_alias: ?[]const u8 = null,

    /// Unique identifier of the connection.
    connection_id: ?[]const u8 = null,

    /// The connection mode.
    connection_mode: ?ConnectionMode = null,

    /// Properties for the outbound connection.
    connection_properties: ?ConnectionProperties = null,

    /// Status of the connection.
    connection_status: ?OutboundConnectionStatus = null,

    /// Information about the source (local) domain.
    local_domain_info: ?DomainInformationContainer = null,

    /// Information about the destination (remote) domain.
    remote_domain_info: ?DomainInformationContainer = null,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_id = "ConnectionId",
        .connection_mode = "ConnectionMode",
        .connection_properties = "ConnectionProperties",
        .connection_status = "ConnectionStatus",
        .local_domain_info = "LocalDomainInfo",
        .remote_domain_info = "RemoteDomainInfo",
    };
};
