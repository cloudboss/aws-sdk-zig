const std = @import("std");

pub const StorageProfileOperatingSystemFamily = enum {
    windows,
    linux,
    macos,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .linux = "LINUX",
        .macos = "MACOS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "WINDOWS",
            .linux => "LINUX",
            .macos => "MACOS",
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
