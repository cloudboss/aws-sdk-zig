const InputType = @import("input_type.zig").InputType;
const MultiviewConfiguration = @import("multiview_configuration.zig").MultiviewConfiguration;
const OutputLockingMode = @import("output_locking_mode.zig").OutputLockingMode;

/// The configuration of the channel.
pub const ChannelListConfiguration = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The multiview channels, in the same channel group, that list this channel as
    /// an available source. This is a read-only field.
    attached_multiview_channels: ?[]const []const u8 = null,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The date and time the channel was created.
    created_at: i64,

    /// Any descriptive information that you want to add to the channel for future
    /// identification purposes.
    description: ?[]const u8 = null,

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

    /// The date and time the channel was modified.
    modified_at: i64,

    /// The multiview configuration for the channel. This is present only when
    /// `InputType` is `MULTIVIEW`.
    multiview_configuration: ?MultiviewConfiguration = null,

    /// The output locking mode configured for the channel.
    ///
    /// The allowed values are:
    ///
    /// * `EPOCH_LOCKED` - The channel uses epoch-locked behavior with deterministic
    ///   sequence numbering and fixed segment boundaries aligned to epoch time.
    /// * `NON_EPOCH_LOCKED` - The channel uses non-epoch-locked behavior with
    ///   duration-based segment combining and monotonically increasing sequence
    ///   numbers starting from 0.
    output_locking_mode: ?OutputLockingMode = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .attached_multiview_channels = "AttachedMultiviewChannels",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .input_type = "InputType",
        .modified_at = "ModifiedAt",
        .multiview_configuration = "MultiviewConfiguration",
        .output_locking_mode = "OutputLockingMode",
    };
};
