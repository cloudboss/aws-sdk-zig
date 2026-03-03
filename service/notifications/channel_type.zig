const std = @import("std");

pub const ChannelType = enum {
    /// AWS Console Mobile App sends notifications to mobile devices.
    /// Link:https://aws.amazon.com/console/mobile/
    mobile,
    /// Chatbot sends notifications to group platforms, like Slack or Chime.
    /// Link:https://aws.amazon.com/chatbot/
    chatbot,
    /// Email sends notifications to email addresses.
    email,
    /// User Notification Service sends notifications to Account Managed contacts.
    account_contact,

    pub const json_field_names = .{
        .mobile = "MOBILE",
        .chatbot = "CHATBOT",
        .email = "EMAIL",
        .account_contact = "ACCOUNT_CONTACT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mobile => "MOBILE",
            .chatbot => "CHATBOT",
            .email => "EMAIL",
            .account_contact => "ACCOUNT_CONTACT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
