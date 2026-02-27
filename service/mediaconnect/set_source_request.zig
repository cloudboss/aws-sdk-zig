const aws = @import("aws");

const Encryption = @import("encryption.zig").Encryption;
const SetGatewayBridgeSourceRequest = @import("set_gateway_bridge_source_request.zig").SetGatewayBridgeSourceRequest;
const MediaStreamSourceConfigurationRequest = @import("media_stream_source_configuration_request.zig").MediaStreamSourceConfigurationRequest;
const NdiSourceSettings = @import("ndi_source_settings.zig").NdiSourceSettings;
const Protocol = @import("protocol.zig").Protocol;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;

/// The settings for the source of the flow.
pub const SetSourceRequest = struct {
    /// The type of encryption that is used on the content ingested from this
    /// source. Allowable encryption types: static-key.
    decryption: ?Encryption,

    /// A description for the source. This value is not used or seen outside of the
    /// current MediaConnect account.
    description: ?[]const u8,

    /// The ARN of the entitlement that allows you to subscribe to this flow. The
    /// entitlement is set by the flow originator, and the ARN is generated as part
    /// of the originator's flow.
    entitlement_arn: ?[]const u8,

    /// The source configuration for cloud flows receiving a stream from a bridge.
    gateway_bridge_source: ?SetGatewayBridgeSourceRequest,

    /// The port that the flow will be listening on for incoming content.
    ingest_port: ?i32,

    /// The smoothing max bitrate (in bps) for RIST, RTP, and RTP-FEC streams.
    max_bitrate: ?i32,

    /// The maximum latency in milliseconds. This parameter applies only to
    /// RIST-based and Zixi-based streams.
    max_latency: ?i32,

    /// The size of the buffer (in milliseconds) to use to sync incoming source
    /// data.
    max_sync_buffer: ?i32,

    /// The media streams that are associated with the source, and the parameters
    /// for those associations.
    media_stream_source_configurations: ?[]const MediaStreamSourceConfigurationRequest,

    /// The minimum latency in milliseconds for SRT-based streams. In streams that
    /// use the SRT protocol, this value that you set on your MediaConnect source or
    /// output represents the minimal potential latency of that connection. The
    /// latency of the stream is set to the highest number between the sender’s
    /// minimum latency and the receiver’s minimum latency.
    min_latency: ?i32,

    /// The name of the source.
    name: ?[]const u8,

    /// The settings for the NDI® source. This includes the exact name of the
    /// upstream NDI sender that you want to connect to your source.
    ndi_source_settings: ?NdiSourceSettings,

    /// The protocol that is used by the source.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol,

    /// Indicates whether to enable or disable router integration when setting a
    /// flow source.
    router_integration_state: ?State,

    /// The decryption configuration for the flow source when router integration is
    /// enabled. Specifies how the source content should be decrypted when router
    /// integration is used.
    router_integration_transit_decryption: ?FlowTransitEncryption,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_control_port: ?i32,

    /// The IP address that the flow communicates with to initiate connection with
    /// the sender.
    sender_ip_address: ?[]const u8,

    /// Source IP or domain name for SRT-caller protocol.
    source_listener_address: ?[]const u8,

    /// Source port for SRT-caller protocol.
    source_listener_port: ?i32,

    /// The key-value pairs that can be used to tag and organize the source.
    source_tags: ?[]const aws.map.StringMapEntry,

    /// The stream ID that you want to use for this transport. This parameter
    /// applies only to Zixi and SRT caller-based streams.
    stream_id: ?[]const u8,

    /// The name of the VPC interface to use for this source.
    vpc_interface_name: ?[]const u8,

    /// The range of IP addresses that should be allowed to contribute content to
    /// your source. These IP addresses should be in the form of a Classless
    /// Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
    whitelist_cidr: ?[]const u8,

    pub const json_field_names = .{
        .decryption = "Decryption",
        .description = "Description",
        .entitlement_arn = "EntitlementArn",
        .gateway_bridge_source = "GatewayBridgeSource",
        .ingest_port = "IngestPort",
        .max_bitrate = "MaxBitrate",
        .max_latency = "MaxLatency",
        .max_sync_buffer = "MaxSyncBuffer",
        .media_stream_source_configurations = "MediaStreamSourceConfigurations",
        .min_latency = "MinLatency",
        .name = "Name",
        .ndi_source_settings = "NdiSourceSettings",
        .protocol = "Protocol",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_decryption = "RouterIntegrationTransitDecryption",
        .sender_control_port = "SenderControlPort",
        .sender_ip_address = "SenderIpAddress",
        .source_listener_address = "SourceListenerAddress",
        .source_listener_port = "SourceListenerPort",
        .source_tags = "SourceTags",
        .stream_id = "StreamId",
        .vpc_interface_name = "VpcInterfaceName",
        .whitelist_cidr = "WhitelistCidr",
    };
};
