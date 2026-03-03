const std = @import("std");

pub const RuleAddressListEmailAttribute = enum {
    recipient,
    mail_from,
    sender,
    from,
    to,
    cc,

    pub const json_field_names = .{
        .recipient = "RECIPIENT",
        .mail_from = "MAIL_FROM",
        .sender = "SENDER",
        .from = "FROM",
        .to = "TO",
        .cc = "CC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .recipient => "RECIPIENT",
            .mail_from => "MAIL_FROM",
            .sender => "SENDER",
            .from => "FROM",
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
