const std = @import("std");

pub const OSVersion = enum {
    windows_10,
    windows_11,

    pub const json_field_names = .{
        .windows_10 = "Windows_10",
        .windows_11 = "Windows_11",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows_10 => "Windows_10",
            .windows_11 => "Windows_11",
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
