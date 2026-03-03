const InputType = @import("input_type.zig").InputType;

/// The configuration of the channel.
pub const ChannelListConfiguration = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

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

    /// The input type will be an immutable field which will be used to define
    /// whether the channel will allow CMAF ingest or HLS ingest. If unprovided, it
    /// will default to HLS to preserve current behavior.
    ///
    /// The allowed values are:
    ///
    /// * `HLS` - The HLS streaming specification (which defines M3U8 manifests and
    ///   TS segments).
    /// * `CMAF` - The DASH-IF CMAF Ingest specification (which defines CMAF
    ///   segments with optional DASH manifests).
    input_type: ?InputType = null,

    /// The date and time the channel was modified.
    modified_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .input_type = "InputType",
        .modified_at = "ModifiedAt",
    };
};
