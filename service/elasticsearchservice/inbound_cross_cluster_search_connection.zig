const InboundCrossClusterSearchConnectionStatus = @import("inbound_cross_cluster_search_connection_status.zig").InboundCrossClusterSearchConnectionStatus;
const DomainInformation = @import("domain_information.zig").DomainInformation;

/// Specifies details of an inbound connection.
pub const InboundCrossClusterSearchConnection = struct {
    /// Specifies the `InboundCrossClusterSearchConnectionStatus` for the outbound
    /// connection.
    connection_status: ?InboundCrossClusterSearchConnectionStatus,

    /// Specifies the connection id for the inbound cross-cluster search connection.
    cross_cluster_search_connection_id: ?[]const u8,

    /// Specifies the `DomainInformation` for the destination Elasticsearch domain.
    destination_domain_info: ?DomainInformation,

    /// Specifies the `DomainInformation` for the source Elasticsearch domain.
    source_domain_info: ?DomainInformation,

    pub const json_field_names = .{
        .connection_status = "ConnectionStatus",
        .cross_cluster_search_connection_id = "CrossClusterSearchConnectionId",
        .destination_domain_info = "DestinationDomainInfo",
        .source_domain_info = "SourceDomainInfo",
    };
};
