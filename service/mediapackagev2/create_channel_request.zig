const aws = @import("aws");

const InputSwitchConfiguration = @import("input_switch_configuration.zig").InputSwitchConfiguration;
const InputType = @import("input_type.zig").InputType;
const MultiviewConfiguration = @import("multiview_configuration.zig").MultiviewConfiguration;
const OutputHeaderConfiguration = @import("output_header_configuration.zig").OutputHeaderConfiguration;
const OutputLockingMode = @import("output_locking_mode.zig").OutputLockingMode;

pub const CreateChannelRequest = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group. You can't change the name after you create the channel.
    channel_name: []const u8,

    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// Enter any descriptive text that helps you to identify the channel.
    description: ?[]const u8 = null,

    /// The configuration for input switching based on the media quality confidence
    /// score (MQCS) as provided from AWS Elemental MediaLive. This setting is valid
    /// only when `InputType` is `CMAF`.
    input_switch_configuration: ?InputSwitchConfiguration = null,

    /// The input type is an immutable field. It defines whether the channel allows
    /// CMAF ingest, HLS ingest, or server-side multiview output. Multiview channels
    /// receive no ingest of their own. If unprovided, the value defaults to HLS.
    ///
    /// The allowed values are:
    ///
    /// * `HLS` - The HLS streaming specification (which defines M3U8 manifests and
    ///   TS segments).
    /// * `CMAF` - The DASH-IF CMAF Ingest specification (which defines CMAF
    ///   segments with optional DASH manifests).
    /// * `MULTIVIEW` – Server-side multiview. The channel receives no ingest of its
    ///   own. Instead, it composites video from the source channels in its
    ///   `MultiviewConfiguration` into a single tiled output stream.
    input_type: ?InputType = null,

    /// The multiview configuration for the channel. This setting is required when
    /// `InputType` is `MULTIVIEW`, and can't be set for any other input type.
    multiview_configuration: ?MultiviewConfiguration = null,

    /// The settings for what common media server data (CMSD) headers AWS Elemental
    /// MediaPackage includes in responses to the CDN. This setting is valid only
    /// when `InputType` is `CMAF`.
    output_header_configuration: ?OutputHeaderConfiguration = null,

    /// The output locking mode for the channel. This setting is only valid when
    /// `InputType` is `CMAF`. This value is immutable after channel creation. If
    /// you don't specify a value, the default is `EPOCH_LOCKED`.
    ///
    /// The allowed values are:
    ///
    /// * `EPOCH_LOCKED` - The channel uses epoch-locked behavior with deterministic
    ///   sequence numbering and fixed segment boundaries aligned to epoch time.
    ///   This mode supports cross-region synchronization and failover.
    /// * `NON_EPOCH_LOCKED` - The channel uses non-epoch-locked behavior with
    ///   duration-based segment combining and monotonically increasing sequence
    ///   numbers starting from 0. This mode does not support cross-region
    ///   synchronization or failover.
    output_locking_mode: ?OutputLockingMode = null,

    /// A comma-separated list of tag key:value pairs that you define. For example:
    ///
    /// `"Key1": "Value1",`
    ///
    /// `"Key2": "Value2"`
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .client_token = "ClientToken",
        .description = "Description",
        .input_switch_configuration = "InputSwitchConfiguration",
        .input_type = "InputType",
        .multiview_configuration = "MultiviewConfiguration",
        .output_header_configuration = "OutputHeaderConfiguration",
        .output_locking_mode = "OutputLockingMode",
        .tags = "Tags",
    };
};
