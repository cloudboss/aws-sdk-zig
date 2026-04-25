const std = @import("std");

pub const OperatingSystemName = enum {
    amazon_linux_2,
    ubuntu_18_04,
    ubuntu_20_04,
    ubuntu_22_04,
    unknown,
    windows_10,
    windows_11,
    windows_7,
    windows_server_2016,
    windows_server_2019,
    windows_server_2022,
    windows_server_2025,
    rhel_8,
    rocky_8,

    pub const json_field_names = .{
        .amazon_linux_2 = "AMAZON_LINUX_2",
        .ubuntu_18_04 = "UBUNTU_18_04",
        .ubuntu_20_04 = "UBUNTU_20_04",
        .ubuntu_22_04 = "UBUNTU_22_04",
        .unknown = "UNKNOWN",
        .windows_10 = "WINDOWS_10",
        .windows_11 = "WINDOWS_11",
        .windows_7 = "WINDOWS_7",
        .windows_server_2016 = "WINDOWS_SERVER_2016",
        .windows_server_2019 = "WINDOWS_SERVER_2019",
        .windows_server_2022 = "WINDOWS_SERVER_2022",
        .windows_server_2025 = "WINDOWS_SERVER_2025",
        .rhel_8 = "RHEL_8",
        .rocky_8 = "ROCKY_8",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_linux_2 => "AMAZON_LINUX_2",
            .ubuntu_18_04 => "UBUNTU_18_04",
            .ubuntu_20_04 => "UBUNTU_20_04",
            .ubuntu_22_04 => "UBUNTU_22_04",
            .unknown => "UNKNOWN",
            .windows_10 => "WINDOWS_10",
            .windows_11 => "WINDOWS_11",
            .windows_7 => "WINDOWS_7",
            .windows_server_2016 => "WINDOWS_SERVER_2016",
            .windows_server_2019 => "WINDOWS_SERVER_2019",
            .windows_server_2022 => "WINDOWS_SERVER_2022",
            .windows_server_2025 => "WINDOWS_SERVER_2025",
            .rhel_8 => "RHEL_8",
            .rocky_8 => "ROCKY_8",
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
