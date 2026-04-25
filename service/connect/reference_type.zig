const std = @import("std");

pub const ReferenceType = enum {
    url,
    attachment,
    contact_analysis,
    number,
    string,
    date,
    email,
    email_message,
    email_message_plain_text,
    email_message_plain_text_redacted,
    email_message_redacted,

    pub const json_field_names = .{
        .url = "URL",
        .attachment = "ATTACHMENT",
        .contact_analysis = "CONTACT_ANALYSIS",
        .number = "NUMBER",
        .string = "STRING",
        .date = "DATE",
        .email = "EMAIL",
        .email_message = "EMAIL_MESSAGE",
        .email_message_plain_text = "EMAIL_MESSAGE_PLAIN_TEXT",
        .email_message_plain_text_redacted = "EMAIL_MESSAGE_PLAIN_TEXT_REDACTED",
        .email_message_redacted = "EMAIL_MESSAGE_REDACTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .url => "URL",
            .attachment => "ATTACHMENT",
            .contact_analysis => "CONTACT_ANALYSIS",
            .number => "NUMBER",
            .string => "STRING",
            .date => "DATE",
            .email => "EMAIL",
            .email_message => "EMAIL_MESSAGE",
            .email_message_plain_text => "EMAIL_MESSAGE_PLAIN_TEXT",
            .email_message_plain_text_redacted => "EMAIL_MESSAGE_PLAIN_TEXT_REDACTED",
            .email_message_redacted => "EMAIL_MESSAGE_REDACTED",
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
