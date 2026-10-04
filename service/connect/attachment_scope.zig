const std = @import("std");

/// The scope of the attachment. Valid values are:
///
/// * `EMAIL` - Attachments for email messages.
///
/// * `CHAT` - Attachments for chat conversations.
///
/// * `CASE` - Attachments for cases.
///
/// * `TASK` - Attachments for tasks.
pub const AttachmentScope = enum {
    email,
    chat,
    case,
    task,

    pub const json_field_names = .{
        .email = "EMAIL",
        .chat = "CHAT",
        .case = "CASE",
        .task = "TASK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email => "EMAIL",
            .chat => "CHAT",
            .case => "CASE",
            .task => "TASK",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
