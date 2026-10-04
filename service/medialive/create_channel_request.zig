const aws = @import("aws");

const AnywhereSettings = @import("anywhere_settings.zig").AnywhereSettings;
const CdiInputSpecification = @import("cdi_input_specification.zig").CdiInputSpecification;
const ChannelClass = @import("channel_class.zig").ChannelClass;
const ChannelEngineVersionRequest = @import("channel_engine_version_request.zig").ChannelEngineVersionRequest;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const EncoderSettings = @import("encoder_settings.zig").EncoderSettings;
const InferenceSettings = @import("inference_settings.zig").InferenceSettings;
const InputAttachment = @import("input_attachment.zig").InputAttachment;
const InputSpecification = @import("input_specification.zig").InputSpecification;
const LinkedChannelSettings = @import("linked_channel_settings.zig").LinkedChannelSettings;
const LogLevel = @import("log_level.zig").LogLevel;
const MaintenanceCreateSettings = @import("maintenance_create_settings.zig").MaintenanceCreateSettings;
const VpcOutputSettings = @import("vpc_output_settings.zig").VpcOutputSettings;

/// A request to create a channel
pub const CreateChannelRequest = struct {
    /// The Elemental Anywhere settings for this channel.
    anywhere_settings: ?AnywhereSettings = null,

    /// Specification of CDI inputs for this channel
    cdi_input_specification: ?CdiInputSpecification = null,

    /// The class for this channel. STANDARD for a channel with two pipelines or
    /// SINGLE_PIPELINE for a channel with one pipeline.
    channel_class: ?ChannelClass = null,

    /// The desired engine version for this channel.
    channel_engine_version: ?ChannelEngineVersionRequest = null,

    /// A list of IDs for all the Input Security Groups attached to the channel.
    channel_security_groups: ?[]const []const u8 = null,

    destinations: ?[]const OutputDestination = null,

    dry_run: ?bool = null,

    encoder_settings: ?EncoderSettings = null,

    /// Include this setting to include Elemental Inference features in this
    /// channel.
    inference_settings: ?InferenceSettings = null,

    /// List of input attachments for channel.
    input_attachments: ?[]const InputAttachment = null,

    /// Specification of network and file inputs for this channel
    input_specification: ?InputSpecification = null,

    /// The linked channel settings for the channel.
    linked_channel_settings: ?LinkedChannelSettings = null,

    /// The log level to write to CloudWatch Logs.
    log_level: ?LogLevel = null,

    /// Maintenance settings for this channel.
    maintenance: ?MaintenanceCreateSettings = null,

    /// Name of channel.
    name: ?[]const u8 = null,

    /// Unique request ID to be specified. This is needed to prevent retries from
    /// creating multiple resources.
    request_id: ?[]const u8 = null,

    /// Deprecated field that's only usable by whitelisted customers.
    reserved: ?[]const u8 = null,

    /// An optional Amazon Resource Name (ARN) of the role to assume when running
    /// the Channel.
    role_arn: ?[]const u8 = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Settings for the VPC outputs
    vpc: ?VpcOutputSettings = null,

    pub const json_field_names = .{
        .anywhere_settings = "AnywhereSettings",
        .cdi_input_specification = "CdiInputSpecification",
        .channel_class = "ChannelClass",
        .channel_engine_version = "ChannelEngineVersion",
        .channel_security_groups = "ChannelSecurityGroups",
        .destinations = "Destinations",
        .dry_run = "DryRun",
        .encoder_settings = "EncoderSettings",
        .inference_settings = "InferenceSettings",
        .input_attachments = "InputAttachments",
        .input_specification = "InputSpecification",
        .linked_channel_settings = "LinkedChannelSettings",
        .log_level = "LogLevel",
        .maintenance = "Maintenance",
        .name = "Name",
        .request_id = "RequestId",
        .reserved = "Reserved",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .vpc = "Vpc",
    };
};
