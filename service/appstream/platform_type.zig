const std = @import("std");

pub const PlatformType = enum {
    windows,
    windows_server_2016,
    windows_server_2019,
    windows_server_2022,
    windows_server_2025,
    amazon_linux2,
    rhel8,
    rocky_linux8,
    ubuntu_pro_2404,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .windows_server_2016 = "WINDOWS_SERVER_2016",
        .windows_server_2019 = "WINDOWS_SERVER_2019",
        .windows_server_2022 = "WINDOWS_SERVER_2022",
        .windows_server_2025 = "WINDOWS_SERVER_2025",
        .amazon_linux2 = "AMAZON_LINUX2",
        .rhel8 = "RHEL8",
        .rocky_linux8 = "ROCKY_LINUX8",
        .ubuntu_pro_2404 = "UBUNTU_PRO_2404",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "WINDOWS",
            .windows_server_2016 => "WINDOWS_SERVER_2016",
            .windows_server_2019 => "WINDOWS_SERVER_2019",
            .windows_server_2022 => "WINDOWS_SERVER_2022",
            .windows_server_2025 => "WINDOWS_SERVER_2025",
            .amazon_linux2 => "AMAZON_LINUX2",
            .rhel8 => "RHEL8",
            .rocky_linux8 => "ROCKY_LINUX8",
            .ubuntu_pro_2404 => "UBUNTU_PRO_2404",
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
