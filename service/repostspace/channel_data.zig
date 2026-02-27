const ChannelStatus = @import("channel_status.zig").ChannelStatus;

/// A structure that contains some information about a channel in a private
/// re:Post.
pub const ChannelData = struct {
    /// A description for the channel. This is used only to help you identify this
    /// channel.
    channel_description: ?[]const u8,

    /// The unique ID of the private re:Post channel.
    channel_id: []const u8,

    /// The name for the channel. This must be unique per private re:Post.
    channel_name: []const u8,

    /// The status pf the channel.
    channel_status: ChannelStatus,

    /// The date when the channel was created.
    create_date_time: i64,

    /// The date when the channel was deleted.
    delete_date_time: ?i64,

    /// The number of groups that are part of the channel.
    group_count: i32,

    /// The unique ID of the private re:Post.
    space_id: []const u8,

    /// The number of users that are part of the channel.
    user_count: i32,

    pub const json_field_names = .{
        .channel_description = "channelDescription",
        .channel_id = "channelId",
        .channel_name = "channelName",
        .channel_status = "channelStatus",
        .create_date_time = "createDateTime",
        .delete_date_time = "deleteDateTime",
        .group_count = "groupCount",
        .space_id = "spaceId",
        .user_count = "userCount",
    };
};
