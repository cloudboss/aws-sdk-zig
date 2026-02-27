const Encryption = @import("encryption.zig").Encryption;
const GatewayBridgeSource = @import("gateway_bridge_source.zig").GatewayBridgeSource;
const MediaStreamSourceConfiguration = @import("media_stream_source_configuration.zig").MediaStreamSourceConfiguration;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;
const Transport = @import("transport.zig").Transport;

/// The settings for the source of the flow.
pub const Source = struct {
    /// The ARN of the router output that's currently connected to this source.
    connected_router_output_arn: ?[]const u8,

    /// Percentage from 0-100 of the data transfer cost to be billed to the
    /// subscriber.
    data_transfer_subscriber_fee_percent: ?i32,

    /// The type of encryption that is used on the content ingested from this
    /// source.
    decryption: ?Encryption,

    /// A description for the source. This value is not used or seen outside of the
    /// current MediaConnect account.
    description: ?[]const u8,

    /// The ARN of the entitlement that allows you to subscribe to content that
    /// comes from another Amazon Web Services account. The entitlement is set by
    /// the content originator and the ARN is generated as part of the originator's
    /// flow.
    entitlement_arn: ?[]const u8,

    /// The source configuration for cloud flows receiving a stream from a bridge.
    gateway_bridge_source: ?GatewayBridgeSource,

    /// The IP address that the flow will be listening on for incoming content.
    ingest_ip: ?[]const u8,

    /// The port that the flow will be listening on for incoming content.
    ingest_port: ?i32,

    /// The media streams that are associated with the source, and the parameters
    /// for those associations.
    media_stream_source_configurations: ?[]const MediaStreamSourceConfiguration,

    /// The name of the source.
    name: []const u8,

    /// The IP address of the device that is currently sending content to this
    /// source.
    ///
    /// * For sources that use protocols where you specify the origin (such as SRT
    ///   Caller), this value matches the configured origin address.
    /// * For sources that use listener protocols (such as SRT Listener or RTP),
    ///   this value shows the address of the connected sender.
    /// * Peer IP addresses aren't available for entitlements and CDI/ST2110
    ///   sources.
    /// * The peer IP address might not be visible for flows that haven't been
    ///   started yet, or flows that were started before May 2025. In these cases,
    ///   restart your flow to see the peer IP address.
    peer_ip_address: ?[]const u8,

    /// Indicates if router integration is enabled or disabled on the flow source.
    router_integration_state: ?State,

    /// The decryption configuration for the flow source when router integration is
    /// enabled.
    router_integration_transit_decryption: ?FlowTransitEncryption,

    /// The IP address that the flow communicates with to initiate connection with
    /// the sender.
    sender_control_port: ?i32,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_ip_address: ?[]const u8,

    /// The ARN of the source.
    source_arn: []const u8,

    /// Attributes related to the transport stream that are used in the source.
    transport: ?Transport,

    /// The name of the VPC interface that is used for this source.
    vpc_interface_name: ?[]const u8,

    /// The range of IP addresses that should be allowed to contribute content to
    /// your source. These IP addresses should be in the form of a Classless
    /// Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
    whitelist_cidr: ?[]const u8,

    pub const json_field_names = .{
        .connected_router_output_arn = "ConnectedRouterOutputArn",
        .data_transfer_subscriber_fee_percent = "DataTransferSubscriberFeePercent",
        .decryption = "Decryption",
        .description = "Description",
        .entitlement_arn = "EntitlementArn",
        .gateway_bridge_source = "GatewayBridgeSource",
        .ingest_ip = "IngestIp",
        .ingest_port = "IngestPort",
        .media_stream_source_configurations = "MediaStreamSourceConfigurations",
        .name = "Name",
        .peer_ip_address = "PeerIpAddress",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_decryption = "RouterIntegrationTransitDecryption",
        .sender_control_port = "SenderControlPort",
        .sender_ip_address = "SenderIpAddress",
        .source_arn = "SourceArn",
        .transport = "Transport",
        .vpc_interface_name = "VpcInterfaceName",
        .whitelist_cidr = "WhitelistCidr",
    };
};
