const std = @import("std");

pub const BotType = enum {
    chat_bot,

    pub const json_field_names = .{
        .chat_bot = "ChatBot",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .chat_bot => "ChatBot",
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
