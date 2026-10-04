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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
