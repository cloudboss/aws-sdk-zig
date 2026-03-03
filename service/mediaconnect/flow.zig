const EncodingConfig = @import("encoding_config.zig").EncodingConfig;
const Entitlement = @import("entitlement.zig").Entitlement;
const FlowSize = @import("flow_size.zig").FlowSize;
const Maintenance = @import("maintenance.zig").Maintenance;
const MediaStream = @import("media_stream.zig").MediaStream;
const NdiConfig = @import("ndi_config.zig").NdiConfig;
const Output = @import("output.zig").Output;
const Source = @import("source.zig").Source;
const FailoverConfig = @import("failover_config.zig").FailoverConfig;
const MonitoringConfig = @import("monitoring_config.zig").MonitoringConfig;
const Status = @import("status.zig").Status;
const VpcInterface = @import("vpc_interface.zig").VpcInterface;

/// The settings for a flow, including its source, outputs, and entitlements.
pub const Flow = struct {
    /// The Availability Zone that you want to create the flow in. These options are
    /// limited to the Availability Zones within the current Amazon Web Services
    /// Region.
    availability_zone: []const u8,

    /// A description of the flow. This value is not used or seen outside of the
    /// current MediaConnect account.
    description: ?[]const u8 = null,

    /// The IP address from which video will be sent to output destinations.
    egress_ip: ?[]const u8 = null,

    /// The encoding configuration to apply to the NDI® source when transcoding it
    /// to a transport stream for downstream distribution.
    encoding_config: ?EncodingConfig = null,

    /// The entitlements in this flow.
    entitlements: []const Entitlement,

    /// The Amazon Resource Name (ARN) of the flow.
    flow_arn: []const u8,

    /// Determines the processing capacity and feature set of the flow.
    flow_size: ?FlowSize = null,

    /// The maintenance settings for the flow.
    maintenance: ?Maintenance = null,

    /// The media streams that are associated with the flow. After you associate a
    /// media stream with a source, you can also associate it with outputs on the
    /// flow.
    media_streams: ?[]const MediaStream = null,

    /// The name of the flow.
    name: []const u8,

    /// Specifies the configuration settings for a flow's NDI source or output.
    /// Required when the flow includes an NDI source or output.
    ndi_config: ?NdiConfig = null,

    /// The outputs in this flow.
    outputs: []const Output,

    /// The source for the flow.
    source: Source,

    /// The settings for the source failover.
    source_failover_config: ?FailoverConfig = null,

    /// The settings for source monitoring.
    source_monitoring_config: ?MonitoringConfig = null,

    /// The settings for the sources that are assigned to the flow.
    sources: ?[]const Source = null,

    /// The current status of the flow.
    status: Status,

    /// The VPC Interfaces for this flow.
    vpc_interfaces: ?[]const VpcInterface = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .description = "Description",
        .egress_ip = "EgressIp",
        .encoding_config = "EncodingConfig",
        .entitlements = "Entitlements",
        .flow_arn = "FlowArn",
        .flow_size = "FlowSize",
        .maintenance = "Maintenance",
        .media_streams = "MediaStreams",
        .name = "Name",
        .ndi_config = "NdiConfig",
        .outputs = "Outputs",
        .source = "Source",
        .source_failover_config = "SourceFailoverConfig",
        .source_monitoring_config = "SourceMonitoringConfig",
        .sources = "Sources",
        .status = "Status",
        .vpc_interfaces = "VpcInterfaces",
    };
};
