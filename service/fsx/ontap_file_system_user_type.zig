const std = @import("std");

pub const OntapFileSystemUserType = enum {
    unix,
    windows,

    pub const json_field_names = .{
        .unix = "UNIX",
        .windows = "WINDOWS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unix => "UNIX",
            .windows => "WINDOWS",
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
