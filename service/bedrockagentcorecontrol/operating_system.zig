const std = @import("std");

/// The operating system and CPU architecture for capacity provider instances.
pub const OperatingSystem = enum {
    linux_x86_64,
    linux_arm64,

    pub const json_field_names = .{
        .linux_x86_64 = "LINUX_X86_64",
        .linux_arm64 = "LINUX_ARM64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linux_x86_64 => "LINUX_X86_64",
            .linux_arm64 => "LINUX_ARM64",
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
