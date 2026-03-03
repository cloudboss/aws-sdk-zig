const std = @import("std");

pub const TargetPlatformArch = enum {
    x86_64,
    x86,
    arm64,
    arm_eabi,
    arm_eabihf,

    pub const json_field_names = .{
        .x86_64 = "X86_64",
        .x86 = "X86",
        .arm64 = "ARM64",
        .arm_eabi = "ARM_EABI",
        .arm_eabihf = "ARM_EABIHF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .x86_64 => "X86_64",
            .x86 => "X86",
            .arm64 => "ARM64",
            .arm_eabi => "ARM_EABI",
            .arm_eabihf => "ARM_EABIHF",
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
