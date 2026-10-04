const std = @import("std");

pub const ThreatIntelIndicatorCategory = enum {
    backdoor,
    card_stealer,
    command_and_control,
    drop_site,
    exploit_site,
    keylogger,

    pub const json_field_names = .{
        .backdoor = "BACKDOOR",
        .card_stealer = "CARD_STEALER",
        .command_and_control = "COMMAND_AND_CONTROL",
        .drop_site = "DROP_SITE",
        .exploit_site = "EXPLOIT_SITE",
        .keylogger = "KEYLOGGER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .backdoor => "BACKDOOR",
            .card_stealer => "CARD_STEALER",
            .command_and_control => "COMMAND_AND_CONTROL",
            .drop_site => "DROP_SITE",
            .exploit_site => "EXPLOIT_SITE",
            .keylogger => "KEYLOGGER",
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
