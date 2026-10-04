const std = @import("std");

pub const Architecture = enum {
    arm64,
    x86_64,

    pub const json_field_names = .{
        .arm64 = "ARM64",
        .x86_64 = "X86_64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .arm64 => "ARM64",
            .x86_64 => "X86_64",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
