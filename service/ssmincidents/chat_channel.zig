const EmptyChatChannel = @import("empty_chat_channel.zig").EmptyChatChannel;

/// The Chatbot chat channel used for collaboration during an incident.
pub const ChatChannel = union(enum) {
    /// The Amazon SNS targets that Chatbot uses to notify the chat channel of
    /// updates to an incident. You can also make updates to the incident through
    /// the chat channel by
    /// using the Amazon SNS topics.
    chatbot_sns: ?[]const []const u8,
    /// Used to remove the chat channel from an incident record or response plan.
    empty: ?EmptyChatChannel,

    pub const json_field_names = .{
        .chatbot_sns = "chatbotSns",
        .empty = "empty",
    };
};
