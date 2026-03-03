const std = @import("std");

pub const PlatformTypeEnum = enum {
    windows,
    windows_byol,
    linux_unix,
    ubuntu_pro,
    rhel,
    linux_byol,
    suse,

    pub const json_field_names = .{
        .windows = "Windows",
        .windows_byol = "Windows BYOL",
        .linux_unix = "Linux/UNIX",
        .ubuntu_pro = "Ubuntu Pro Linux",
        .rhel = "Red Hat Enterprise Linux",
        .linux_byol = "Red Hat BYOL Linux",
        .suse = "SUSE Linux",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "Windows",
            .windows_byol => "Windows BYOL",
            .linux_unix => "Linux/UNIX",
            .ubuntu_pro => "Ubuntu Pro Linux",
            .rhel => "Red Hat Enterprise Linux",
            .linux_byol => "Red Hat BYOL Linux",
            .suse => "SUSE Linux",
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
