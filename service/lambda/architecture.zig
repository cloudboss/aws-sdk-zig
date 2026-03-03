const std = @import("std");

pub const Architecture = enum {
    x_86_64,
    arm_64,

    pub const json_field_names = .{
        .x_86_64 = "x86_64",
        .arm_64 = "arm64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .x_86_64 => "x86_64",
            .arm_64 => "arm64",
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
