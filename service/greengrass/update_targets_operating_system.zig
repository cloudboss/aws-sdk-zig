const std = @import("std");

/// The operating system of the cores which are the targets of an update.
pub const UpdateTargetsOperatingSystem = enum {
    ubuntu,
    raspbian,
    amazon_linux,
    openwrt,

    pub const json_field_names = .{
        .ubuntu = "ubuntu",
        .raspbian = "raspbian",
        .amazon_linux = "amazon_linux",
        .openwrt = "openwrt",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ubuntu => "ubuntu",
            .raspbian => "raspbian",
            .amazon_linux => "amazon_linux",
            .openwrt => "openwrt",
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
