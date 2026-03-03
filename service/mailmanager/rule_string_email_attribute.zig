const std = @import("std");

pub const RuleStringEmailAttribute = enum {
    mail_from,
    helo,
    recipient,
    sender,
    from,
    subject,
    to,
    cc,

    pub const json_field_names = .{
        .mail_from = "MAIL_FROM",
        .helo = "HELO",
        .recipient = "RECIPIENT",
        .sender = "SENDER",
        .from = "FROM",
        .subject = "SUBJECT",
        .to = "TO",
        .cc = "CC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mail_from => "MAIL_FROM",
            .helo => "HELO",
            .recipient => "RECIPIENT",
            .sender => "SENDER",
            .from => "FROM",
            .subject => "SUBJECT",
            .to => "TO",
            .cc => "CC",
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
