const std = @import("std");

pub const RemoteManagement = enum {
    installed_only,
    installed_autostart,
    not_installed,

    pub const json_field_names = .{
        .installed_only = "INSTALLED_ONLY",
        .installed_autostart = "INSTALLED_AUTOSTART",
        .not_installed = "NOT_INSTALLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .installed_only => "INSTALLED_ONLY",
            .installed_autostart => "INSTALLED_AUTOSTART",
            .not_installed => "NOT_INSTALLED",
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
