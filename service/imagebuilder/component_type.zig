const std = @import("std");

pub const ComponentType = enum {
    build,
    @"test",

    pub const json_field_names = .{
        .build = "BUILD",
        .@"test" = "TEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .build => "BUILD",
            .@"test" => "TEST",
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
