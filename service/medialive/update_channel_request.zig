const AnywhereSettings = @import("anywhere_settings.zig").AnywhereSettings;
const CdiInputSpecification = @import("cdi_input_specification.zig").CdiInputSpecification;
const ChannelEngineVersionRequest = @import("channel_engine_version_request.zig").ChannelEngineVersionRequest;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const EncoderSettings = @import("encoder_settings.zig").EncoderSettings;
const InferenceSettings = @import("inference_settings.zig").InferenceSettings;
const InputAttachment = @import("input_attachment.zig").InputAttachment;
const InputSpecification = @import("input_specification.zig").InputSpecification;
const LinkedChannelSettings = @import("linked_channel_settings.zig").LinkedChannelSettings;
const LogLevel = @import("log_level.zig").LogLevel;
const MaintenanceUpdateSettings = @import("maintenance_update_settings.zig").MaintenanceUpdateSettings;
const SpecialRouterSettings = @import("special_router_settings.zig").SpecialRouterSettings;

/// A request to update a channel.
pub const UpdateChannelRequest = struct {
    /// The Elemental Anywhere settings for this channel.
    anywhere_settings: ?AnywhereSettings = null,

    /// Specification of CDI inputs for this channel
    cdi_input_specification: ?CdiInputSpecification = null,

    /// Channel engine version for this channel
    channel_engine_version: ?ChannelEngineVersionRequest = null,

    /// channel ID
    channel_id: []const u8,

    /// A list of IDs for all the Input Security Groups attached to the channel.
    channel_security_groups: ?[]const []const u8 = null,

    /// A list of output destinations for this channel.
    destinations: ?[]const OutputDestination = null,

    dry_run: ?bool = null,

    /// The encoder settings for this channel.
    encoder_settings: ?EncoderSettings = null,

    /// Include this setting to include Elemental Inference features in this
    /// channel.
    inference_settings: ?InferenceSettings = null,

    input_attachments: ?[]const InputAttachment = null,

    /// Specification of network and file inputs for this channel
    input_specification: ?InputSpecification = null,

    /// The linked channel settings for the channel.
    linked_channel_settings: ?LinkedChannelSettings = null,

    /// The log level to write to CloudWatch Logs.
    log_level: ?LogLevel = null,

    /// Maintenance settings for this channel.
    maintenance: ?MaintenanceUpdateSettings = null,

    /// The name of the channel.
    name: ?[]const u8 = null,

    /// An optional Amazon Resource Name (ARN) of the role to assume when running
    /// the Channel. If you do not specify this on an update call but the role was
    /// previously set that role will be removed.
    role_arn: ?[]const u8 = null,

    /// When using MediaConnect Router as the source of a MediaLive input there's a
    /// special handoff that occurs when a router output
    /// is created. This group of settings is set on your behalf by the MediaConnect
    /// Router service using this set of settings. This
    /// setting object can only by used by that service.
    special_router_settings: ?SpecialRouterSettings = null,

    pub const json_field_names = .{
        .anywhere_settings = "AnywhereSettings",
        .cdi_input_specification = "CdiInputSpecification",
        .channel_engine_version = "ChannelEngineVersion",
        .channel_id = "ChannelId",
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
        .role_arn = "RoleArn",
        .special_router_settings = "SpecialRouterSettings",
    };
};
