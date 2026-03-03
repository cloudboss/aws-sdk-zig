const std = @import("std");

pub const BotFilterName = enum {
    bot_name,
    bot_type,

    pub const json_field_names = .{
        .bot_name = "BotName",
        .bot_type = "BotType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bot_name => "BotName",
            .bot_type => "BotType",
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
