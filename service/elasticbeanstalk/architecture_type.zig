const std = @import("std");

pub const ArchitectureType = enum {
    amd_64,
    arm_64,

    pub const json_field_names = .{
        .amd_64 = "amd64",
        .arm_64 = "arm64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amd_64 => "amd64",
            .arm_64 => "arm64",
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
