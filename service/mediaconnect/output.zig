const Encryption = @import("encryption.zig").Encryption;
const MediaStreamOutputConfiguration = @import("media_stream_output_configuration.zig").MediaStreamOutputConfiguration;
const OutputStatus = @import("output_status.zig").OutputStatus;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;
const Transport = @import("transport.zig").Transport;
const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// The settings for an output.
pub const Output = struct {
    /// The ARN of the bridge added to this output.
    bridge_arn: ?[]const u8 = null,

    /// The bridge output ports currently in use.
    bridge_ports: ?[]const i32 = null,

    /// The ARN of the router input that's connected to this flow output.
    connected_router_input_arn: ?[]const u8 = null,

    /// Percentage from 0-100 of the data transfer cost to be billed to the
    /// subscriber.
    data_transfer_subscriber_fee_percent: ?i32 = null,

    /// A description of the output.
    description: ?[]const u8 = null,

    /// The address where you want to send the output.
    destination: ?[]const u8 = null,

    /// The type of key used for the encryption. If no keyType is provided, the
    /// service will use the default setting (static-key).
    encryption: ?Encryption = null,

    /// The ARN of the entitlement on the originator''s flow. This value is relevant
    /// only on entitled flows.
    entitlement_arn: ?[]const u8 = null,

    /// The IP address that the receiver requires in order to establish a connection
    /// with the flow. For public networking, the ListenerAddress is represented by
    /// the elastic IP address of the flow. For private networking, the
    /// ListenerAddress is represented by the elastic network interface IP address
    /// of the VPC. This field applies only to outputs that use the Zixi pull or SRT
    /// listener protocol.
    listener_address: ?[]const u8 = null,

    /// The input ARN of the MediaLive channel. This parameter is relevant only for
    /// outputs that were added by creating a MediaLive input.
    media_live_input_arn: ?[]const u8 = null,

    /// The configuration for each media stream that is associated with the output.
    media_stream_output_configurations: ?[]const MediaStreamOutputConfiguration = null,

    /// The name of the output. This value must be unique within the current flow.
    name: []const u8,

    /// The ARN of the output.
    output_arn: []const u8,

    /// An indication of whether the output is transmitting data or not.
    output_status: ?OutputStatus = null,

    /// The IP address of the device that is currently receiving content from this
    /// output.
    ///
    /// * For outputs that use protocols where you specify the destination (such as
    ///   SRT Caller or Zixi Push), this value matches the configured destination
    ///   address.
    /// * For outputs that use listener protocols (such as SRT Listener), this value
    ///   shows the address of the connected receiver.
    /// * Peer IP addresses aren't available for entitlements, managed MediaLive
    ///   outputs, NDI® sources and outputs, and CDI/ST2110 outputs.
    /// * The peer IP address might not be visible for flows that haven't been
    ///   started yet, or flows that were started before May 2025. In these cases,
    ///   restart your flow to see the peer IP address.
    peer_ip_address: ?[]const u8 = null,

    /// The port to use when content is distributed to this output.
    port: ?i32 = null,

    /// Indicates if router integration is enabled or disabled on the flow output.
    router_integration_state: ?State = null,

    /// The encryption configuration for the output when router integration is
    /// enabled.
    router_integration_transit_encryption: ?FlowTransitEncryption = null,

    /// Attributes related to the transport stream that are used in the output.
    transport: ?Transport = null,

    /// The name of the VPC interface attachment to use for this output.
    vpc_interface_attachment: ?VpcInterfaceAttachment = null,

    pub const json_field_names = .{
        .bridge_arn = "BridgeArn",
        .bridge_ports = "BridgePorts",
        .connected_router_input_arn = "ConnectedRouterInputArn",
        .data_transfer_subscriber_fee_percent = "DataTransferSubscriberFeePercent",
        .description = "Description",
        .destination = "Destination",
        .encryption = "Encryption",
        .entitlement_arn = "EntitlementArn",
        .listener_address = "ListenerAddress",
        .media_live_input_arn = "MediaLiveInputArn",
        .media_stream_output_configurations = "MediaStreamOutputConfigurations",
        .name = "Name",
        .output_arn = "OutputArn",
        .output_status = "OutputStatus",
        .peer_ip_address = "PeerIpAddress",
        .port = "Port",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_encryption = "RouterIntegrationTransitEncryption",
        .transport = "Transport",
        .vpc_interface_attachment = "VpcInterfaceAttachment",
    };
};
