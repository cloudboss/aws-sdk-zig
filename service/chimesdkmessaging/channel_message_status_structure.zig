const ChannelMessageStatus = @import("channel_message_status.zig").ChannelMessageStatus;

/// Stores information about a message status.
pub const ChannelMessageStatusStructure = struct {
    /// Contains more details about the message status.
    detail: ?[]const u8,

    /// The message status value.
    value: ?ChannelMessageStatus,

    pub const json_field_names = .{
        .detail = "Detail",
        .value = "Value",
    };
};
