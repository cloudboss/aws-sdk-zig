const std = @import("std");

pub const GameServerProtectionPolicy = enum {
    no_protection,
    full_protection,

    pub const json_field_names = .{
        .no_protection = "NO_PROTECTION",
        .full_protection = "FULL_PROTECTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_protection => "NO_PROTECTION",
            .full_protection => "FULL_PROTECTION",
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
