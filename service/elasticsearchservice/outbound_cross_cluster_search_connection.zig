const OutboundCrossClusterSearchConnectionStatus = @import("outbound_cross_cluster_search_connection_status.zig").OutboundCrossClusterSearchConnectionStatus;
const DomainInformation = @import("domain_information.zig").DomainInformation;

/// Specifies details of an outbound connection.
pub const OutboundCrossClusterSearchConnection = struct {
    /// Specifies the connection alias for the outbound cross-cluster search
    /// connection.
    connection_alias: ?[]const u8,

    /// Specifies the `OutboundCrossClusterSearchConnectionStatus` for the outbound
    /// connection.
    connection_status: ?OutboundCrossClusterSearchConnectionStatus,

    /// Specifies the connection id for the outbound cross-cluster search
    /// connection.
    cross_cluster_search_connection_id: ?[]const u8,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: ?DomainInformation,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: ?DomainInformation,

    pub const json_field_names = .{
        .connection_alias = "ConnectionAlias",
        .connection_status = "ConnectionStatus",
        .cross_cluster_search_connection_id = "CrossClusterSearchConnectionId",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};
