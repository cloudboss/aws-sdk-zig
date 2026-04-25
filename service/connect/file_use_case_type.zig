const std = @import("std");

pub const FileUseCaseType = enum {
    contact_analysis,
    email_message,
    email_message_plain_text,
    email_message_redacted,
    email_message_plain_text_redacted,
    attachment,

    pub const json_field_names = .{
        .contact_analysis = "CONTACT_ANALYSIS",
        .email_message = "EMAIL_MESSAGE",
        .email_message_plain_text = "EMAIL_MESSAGE_PLAIN_TEXT",
        .email_message_redacted = "EMAIL_MESSAGE_REDACTED",
        .email_message_plain_text_redacted = "EMAIL_MESSAGE_PLAIN_TEXT_REDACTED",
        .attachment = "ATTACHMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contact_analysis => "CONTACT_ANALYSIS",
            .email_message => "EMAIL_MESSAGE",
            .email_message_plain_text => "EMAIL_MESSAGE_PLAIN_TEXT",
            .email_message_redacted => "EMAIL_MESSAGE_REDACTED",
            .email_message_plain_text_redacted => "EMAIL_MESSAGE_PLAIN_TEXT_REDACTED",
            .attachment => "ATTACHMENT",
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
