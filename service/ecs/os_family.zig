const std = @import("std");

pub const OSFamily = enum {
    windows_server_2019_full,
    windows_server_2019_core,
    windows_server_2016_full,
    windows_server_2004_core,
    windows_server_2022_core,
    windows_server_2022_full,
    windows_server_2025_core,
    windows_server_2025_full,
    windows_server_20_h2_core,
    linux,

    pub const json_field_names = .{
        .windows_server_2019_full = "WINDOWS_SERVER_2019_FULL",
        .windows_server_2019_core = "WINDOWS_SERVER_2019_CORE",
        .windows_server_2016_full = "WINDOWS_SERVER_2016_FULL",
        .windows_server_2004_core = "WINDOWS_SERVER_2004_CORE",
        .windows_server_2022_core = "WINDOWS_SERVER_2022_CORE",
        .windows_server_2022_full = "WINDOWS_SERVER_2022_FULL",
        .windows_server_2025_core = "WINDOWS_SERVER_2025_CORE",
        .windows_server_2025_full = "WINDOWS_SERVER_2025_FULL",
        .windows_server_20_h2_core = "WINDOWS_SERVER_20H2_CORE",
        .linux = "LINUX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows_server_2019_full => "WINDOWS_SERVER_2019_FULL",
            .windows_server_2019_core => "WINDOWS_SERVER_2019_CORE",
            .windows_server_2016_full => "WINDOWS_SERVER_2016_FULL",
            .windows_server_2004_core => "WINDOWS_SERVER_2004_CORE",
            .windows_server_2022_core => "WINDOWS_SERVER_2022_CORE",
            .windows_server_2022_full => "WINDOWS_SERVER_2022_FULL",
            .windows_server_2025_core => "WINDOWS_SERVER_2025_CORE",
            .windows_server_2025_full => "WINDOWS_SERVER_2025_FULL",
            .windows_server_20_h2_core => "WINDOWS_SERVER_20H2_CORE",
            .linux => "LINUX",
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
