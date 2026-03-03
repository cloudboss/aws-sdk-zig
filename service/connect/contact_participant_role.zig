const std = @import("std");

pub const ContactParticipantRole = enum {
    agent,
    system,
    custom_bot,

    pub const json_field_names = .{
        .agent = "AGENT",
        .system = "SYSTEM",
        .custom_bot = "CUSTOM_BOT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agent => "AGENT",
            .system => "SYSTEM",
            .custom_bot => "CUSTOM_BOT",
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
