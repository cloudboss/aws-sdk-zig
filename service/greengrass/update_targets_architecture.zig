const std = @import("std");

/// The architecture of the cores which are the targets of an update.
pub const UpdateTargetsArchitecture = enum {
    armv_6_l,
    armv_7_l,
    x_86_64,
    aarch_64,

    pub const json_field_names = .{
        .armv_6_l = "armv6l",
        .armv_7_l = "armv7l",
        .x_86_64 = "x86_64",
        .aarch_64 = "aarch64",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .armv_6_l => "armv6l",
            .armv_7_l => "armv7l",
            .x_86_64 => "x86_64",
            .aarch_64 => "aarch64",
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
