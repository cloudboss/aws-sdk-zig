const aws = @import("aws");

const DescribeAnywhereSettings = @import("describe_anywhere_settings.zig").DescribeAnywhereSettings;
const CdiInputSpecification = @import("cdi_input_specification.zig").CdiInputSpecification;
const ChannelClass = @import("channel_class.zig").ChannelClass;
const ChannelEngineVersionResponse = @import("channel_engine_version_response.zig").ChannelEngineVersionResponse;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const ChannelEgressEndpoint = @import("channel_egress_endpoint.zig").ChannelEgressEndpoint;
const EncoderSettings = @import("encoder_settings.zig").EncoderSettings;
const InputAttachment = @import("input_attachment.zig").InputAttachment;
const InputSpecification = @import("input_specification.zig").InputSpecification;
const DescribeLinkedChannelSettings = @import("describe_linked_channel_settings.zig").DescribeLinkedChannelSettings;
const LogLevel = @import("log_level.zig").LogLevel;
const MaintenanceStatus = @import("maintenance_status.zig").MaintenanceStatus;
const PipelineDetail = @import("pipeline_detail.zig").PipelineDetail;
const ChannelState = @import("channel_state.zig").ChannelState;
const VpcOutputSettingsDescription = @import("vpc_output_settings_description.zig").VpcOutputSettingsDescription;

/// Placeholder documentation for Channel
pub const Channel = struct {
    /// Anywhere settings for this channel.
    anywhere_settings: ?DescribeAnywhereSettings,

    /// The unique arn of the channel.
    arn: ?[]const u8,

    /// Specification of CDI inputs for this channel
    cdi_input_specification: ?CdiInputSpecification,

    /// The class for this channel. STANDARD for a channel with two pipelines or
    /// SINGLE_PIPELINE for a channel with one pipeline.
    channel_class: ?ChannelClass,

    /// Requested engine version for this channel.
    channel_engine_version: ?ChannelEngineVersionResponse,

    /// A list of IDs for all the Input Security Groups attached to the channel.
    channel_security_groups: ?[]const []const u8,

    /// A list of destinations of the channel. For UDP outputs, there is one
    /// destination per output. For other types (HLS, for example), there is
    /// one destination per packager.
    destinations: ?[]const OutputDestination,

    /// The endpoints where outgoing connections initiate from
    egress_endpoints: ?[]const ChannelEgressEndpoint,

    encoder_settings: ?EncoderSettings,

    /// The unique id of the channel.
    id: ?[]const u8,

    /// List of input attachments for channel.
    input_attachments: ?[]const InputAttachment,

    /// Specification of network and file inputs for this channel
    input_specification: ?InputSpecification,

    /// Linked Channel Settings for this channel.
    linked_channel_settings: ?DescribeLinkedChannelSettings,

    /// The log level being written to CloudWatch Logs.
    log_level: ?LogLevel,

    /// Maintenance settings for this channel.
    maintenance: ?MaintenanceStatus,

    /// The name of the channel. (user-mutable)
    name: ?[]const u8,

    /// Runtime details for the pipelines of a running channel.
    pipeline_details: ?[]const PipelineDetail,

    /// The number of currently healthy pipelines.
    pipelines_running_count: ?i32,

    /// The Amazon Resource Name (ARN) of the role assumed when running the Channel.
    role_arn: ?[]const u8,

    state: ?ChannelState,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry,

    /// Settings for VPC output
    vpc: ?VpcOutputSettingsDescription,

    pub const json_field_names = .{
        .anywhere_settings = "AnywhereSettings",
        .arn = "Arn",
        .cdi_input_specification = "CdiInputSpecification",
        .channel_class = "ChannelClass",
        .channel_engine_version = "ChannelEngineVersion",
        .channel_security_groups = "ChannelSecurityGroups",
        .destinations = "Destinations",
        .egress_endpoints = "EgressEndpoints",
        .encoder_settings = "EncoderSettings",
        .id = "Id",
        .input_attachments = "InputAttachments",
        .input_specification = "InputSpecification",
        .linked_channel_settings = "LinkedChannelSettings",
        .log_level = "LogLevel",
        .maintenance = "Maintenance",
        .name = "Name",
        .pipeline_details = "PipelineDetails",
        .pipelines_running_count = "PipelinesRunningCount",
        .role_arn = "RoleArn",
        .state = "State",
        .tags = "Tags",
        .vpc = "Vpc",
    };
};
