const aws = @import("aws");

const InputDestination = @import("input_destination.zig").InputDestination;
const InputClass = @import("input_class.zig").InputClass;
const InputDeviceSettings = @import("input_device_settings.zig").InputDeviceSettings;
const InputNetworkLocation = @import("input_network_location.zig").InputNetworkLocation;
const InputSourceType = @import("input_source_type.zig").InputSourceType;
const MediaConnectFlow = @import("media_connect_flow.zig").MediaConnectFlow;
const MulticastSettings = @import("multicast_settings.zig").MulticastSettings;
const RouterInputSettings = @import("router_input_settings.zig").RouterInputSettings;
const Smpte2110ReceiverGroupSettings = @import("smpte_2110_receiver_group_settings.zig").Smpte2110ReceiverGroupSettings;
const InputSource = @import("input_source.zig").InputSource;
const SrtSettings = @import("srt_settings.zig").SrtSettings;
const InputState = @import("input_state.zig").InputState;
const InputType = @import("input_type.zig").InputType;

/// Placeholder documentation for Input
pub const Input = struct {
    /// The Unique ARN of the input (generated, immutable).
    arn: ?[]const u8,

    /// A list of channel IDs that that input is attached to (currently an input can
    /// only be attached to one channel).
    attached_channels: ?[]const []const u8,

    /// A list of the destinations of the input (PUSH-type).
    destinations: ?[]const InputDestination,

    /// The generated ID of the input (unique for user account, immutable).
    id: ?[]const u8,

    /// STANDARD - MediaLive expects two sources to be connected to this input. If
    /// the channel is also STANDARD, both sources will be ingested. If the channel
    /// is SINGLE_PIPELINE, only the first source will be ingested; the second
    /// source will always be ignored, even if the first source fails.
    /// SINGLE_PIPELINE - You can connect only one source to this input. If the
    /// ChannelClass is also SINGLE_PIPELINE, this value is valid. If the
    /// ChannelClass is STANDARD, this value is not valid because the channel
    /// requires two sources in the input.
    input_class: ?InputClass,

    /// Settings for the input devices.
    input_devices: ?[]const InputDeviceSettings,

    /// The location of this input. AWS, for an input existing in the AWS Cloud,
    /// On-Prem for
    /// an input in a customer network.
    input_network_location: ?InputNetworkLocation,

    /// A list of IDs for all Inputs which are partners of this one.
    input_partner_ids: ?[]const []const u8,

    /// Certain pull input sources can be dynamic, meaning that they can have their
    /// URL's dynamically changes
    /// during input switch actions. Presently, this functionality only works with
    /// MP4_FILE and TS_FILE inputs.
    input_source_type: ?InputSourceType,

    /// A list of MediaConnect Flows for this input.
    media_connect_flows: ?[]const MediaConnectFlow,

    /// Multicast Input settings.
    multicast_settings: ?MulticastSettings,

    /// The user-assigned name (This is a mutable value).
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the role this input assumes during and
    /// after creation.
    role_arn: ?[]const u8,

    /// Information about any MediaConnect router association with this input.
    router_settings: ?RouterInputSettings,

    sdi_sources: ?[]const []const u8,

    /// A list of IDs for all the Input Security Groups attached to the input.
    security_groups: ?[]const []const u8,

    /// Include this parameter if the input is a SMPTE 2110 input, to identify the
    /// stream sources for this input.
    smpte_2110_receiver_group_settings: ?Smpte2110ReceiverGroupSettings,

    /// A list of the sources of the input (PULL-type).
    sources: ?[]const InputSource,

    /// The settings associated with an SRT input.
    srt_settings: ?SrtSettings,

    state: ?InputState,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry,

    type: ?InputType,

    pub const json_field_names = .{
        .arn = "Arn",
        .attached_channels = "AttachedChannels",
        .destinations = "Destinations",
        .id = "Id",
        .input_class = "InputClass",
        .input_devices = "InputDevices",
        .input_network_location = "InputNetworkLocation",
        .input_partner_ids = "InputPartnerIds",
        .input_source_type = "InputSourceType",
        .media_connect_flows = "MediaConnectFlows",
        .multicast_settings = "MulticastSettings",
        .name = "Name",
        .role_arn = "RoleArn",
        .router_settings = "RouterSettings",
        .sdi_sources = "SdiSources",
        .security_groups = "SecurityGroups",
        .smpte_2110_receiver_group_settings = "Smpte2110ReceiverGroupSettings",
        .sources = "Sources",
        .srt_settings = "SrtSettings",
        .state = "State",
        .tags = "Tags",
        .type = "Type",
    };
};
