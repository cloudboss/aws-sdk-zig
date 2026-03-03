const std = @import("std");

pub const PrefixType = enum {
    filename,
    path,
    path_and_filename,

    pub const json_field_names = .{
        .filename = "FILENAME",
        .path = "PATH",
        .path_and_filename = "PATH_AND_FILENAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .filename => "FILENAME",
            .path => "PATH",
            .path_and_filename => "PATH_AND_FILENAME",
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
