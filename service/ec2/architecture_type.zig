const std = @import("std");

pub const ArchitectureType = enum {
    i_386,
    x_86_64,
    arm_64,
    x_86_64_mac,
    arm_64_mac,

    pub const json_field_names = .{
        .i_386 = "i386",
        .x_86_64 = "x86_64",
        .arm_64 = "arm64",
        .x_86_64_mac = "x86_64_mac",
        .arm_64_mac = "arm64_mac",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .i_386 => "i386",
            .x_86_64 => "x86_64",
            .arm_64 => "arm64",
            .x_86_64_mac => "x86_64_mac",
            .arm_64_mac => "arm64_mac",
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
