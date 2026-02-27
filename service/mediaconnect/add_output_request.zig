const aws = @import("aws");

const Encryption = @import("encryption.zig").Encryption;
const MediaStreamOutputConfigurationRequest = @import("media_stream_output_configuration_request.zig").MediaStreamOutputConfigurationRequest;
const OutputStatus = @import("output_status.zig").OutputStatus;
const Protocol = @import("protocol.zig").Protocol;
const State = @import("state.zig").State;
const FlowTransitEncryption = @import("flow_transit_encryption.zig").FlowTransitEncryption;
const VpcInterfaceAttachment = @import("vpc_interface_attachment.zig").VpcInterfaceAttachment;

/// A request to add an output to a flow.
pub const AddOutputRequest = struct {
    /// The range of IP addresses that should be allowed to initiate output requests
    /// to this flow. These IP addresses should be in the form of a Classless
    /// Inter-Domain Routing (CIDR) block; for example, 10.0.0.0/16.
    cidr_allow_list: ?[]const []const u8,

    /// A description of the output. This description appears only on the Audit
    /// Manager console and will not be seen by the end user.
    description: ?[]const u8,

    /// The IP address from which video will be sent to output destinations.
    destination: ?[]const u8,

    /// The type of key used for the encryption. If no keyType is provided, the
    /// service will use the default setting (static-key). Allowable encryption
    /// types: static-key.
    encryption: ?Encryption,

    /// The maximum latency in milliseconds. This parameter applies only to
    /// RIST-based and Zixi-based streams.
    max_latency: ?i32,

    /// The media streams that are associated with the output, and the parameters
    /// for those associations.
    media_stream_output_configurations: ?[]const MediaStreamOutputConfigurationRequest,

    /// The minimum latency in milliseconds for SRT-based streams. In streams that
    /// use the SRT protocol, this value that you set on your MediaConnect source or
    /// output represents the minimal potential latency of that connection. The
    /// latency of the stream is set to the highest number between the sender’s
    /// minimum latency and the receiver’s minimum latency.
    min_latency: ?i32,

    /// The name of the output. This value must be unique within the current flow.
    name: ?[]const u8,

    /// A suffix for the name of the NDI® sender that the flow creates. If a custom
    /// name isn't specified, MediaConnect uses the output name.
    ndi_program_name: ?[]const u8,

    /// A quality setting for the NDI Speed HQ encoder.
    ndi_speed_hq_quality: ?i32,

    /// An indication of whether the new output should be enabled or disabled as
    /// soon as it is created. If you don't specify the outputStatus field in your
    /// request, MediaConnect sets it to ENABLED.
    output_status: ?OutputStatus,

    /// The key-value pairs that can be used to tag and organize the output.
    output_tags: ?[]const aws.map.StringMapEntry,

    /// The port to use when content is distributed to this output.
    port: ?i32,

    /// The protocol to use for the output.
    ///
    /// Elemental MediaConnect no longer supports the Fujitsu QoS protocol. This
    /// reference is maintained for legacy purposes only.
    protocol: ?Protocol,

    /// The remote ID for the Zixi-pull output stream.
    remote_id: ?[]const u8,

    /// Indicates whether to enable or disable router integration when creating a
    /// new flow output.
    router_integration_state: ?State,

    router_integration_transit_encryption: ?FlowTransitEncryption,

    /// The port that the flow uses to send outbound requests to initiate connection
    /// with the sender.
    sender_control_port: ?i32,

    /// The smoothing latency in milliseconds for RIST, RTP, and RTP-FEC streams.
    smoothing_latency: ?i32,

    /// The stream ID that you want to use for this transport. This parameter
    /// applies only to Zixi and SRT caller-based streams.
    stream_id: ?[]const u8,

    /// The name of the VPC interface attachment to use for this output.
    vpc_interface_attachment: ?VpcInterfaceAttachment,

    pub const json_field_names = .{
        .cidr_allow_list = "CidrAllowList",
        .description = "Description",
        .destination = "Destination",
        .encryption = "Encryption",
        .max_latency = "MaxLatency",
        .media_stream_output_configurations = "MediaStreamOutputConfigurations",
        .min_latency = "MinLatency",
        .name = "Name",
        .ndi_program_name = "NdiProgramName",
        .ndi_speed_hq_quality = "NdiSpeedHqQuality",
        .output_status = "OutputStatus",
        .output_tags = "OutputTags",
        .port = "Port",
        .protocol = "Protocol",
        .remote_id = "RemoteId",
        .router_integration_state = "RouterIntegrationState",
        .router_integration_transit_encryption = "RouterIntegrationTransitEncryption",
        .sender_control_port = "SenderControlPort",
        .smoothing_latency = "SmoothingLatency",
        .stream_id = "StreamId",
        .vpc_interface_attachment = "VpcInterfaceAttachment",
    };
};
