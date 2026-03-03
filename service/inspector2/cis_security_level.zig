const std = @import("std");

pub const CisSecurityLevel = enum {
    level_1,
    level_2,

    pub const json_field_names = .{
        .level_1 = "LEVEL_1",
        .level_2 = "LEVEL_2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .level_1 => "LEVEL_1",
            .level_2 => "LEVEL_2",
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
