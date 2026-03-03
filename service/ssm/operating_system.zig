const std = @import("std");

pub const OperatingSystem = enum {
    windows,
    amazon_linux,
    amazon_linux_2,
    amazon_linux_2022,
    ubuntu,
    redhat_enterprise_linux,
    suse,
    cent_os,
    oracle_linux,
    debian,
    mac_os,
    raspbian,
    rocky_linux,
    alma_linux,
    amazon_linux_2023,

    pub const json_field_names = .{
        .windows = "WINDOWS",
        .amazon_linux = "AMAZON_LINUX",
        .amazon_linux_2 = "AMAZON_LINUX_2",
        .amazon_linux_2022 = "AMAZON_LINUX_2022",
        .ubuntu = "UBUNTU",
        .redhat_enterprise_linux = "REDHAT_ENTERPRISE_LINUX",
        .suse = "SUSE",
        .cent_os = "CENTOS",
        .oracle_linux = "ORACLE_LINUX",
        .debian = "DEBIAN",
        .mac_os = "MACOS",
        .raspbian = "RASPBIAN",
        .rocky_linux = "ROCKY_LINUX",
        .alma_linux = "ALMA_LINUX",
        .amazon_linux_2023 = "AMAZON_LINUX_2023",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .windows => "WINDOWS",
            .amazon_linux => "AMAZON_LINUX",
            .amazon_linux_2 => "AMAZON_LINUX_2",
            .amazon_linux_2022 => "AMAZON_LINUX_2022",
            .ubuntu => "UBUNTU",
            .redhat_enterprise_linux => "REDHAT_ENTERPRISE_LINUX",
            .suse => "SUSE",
            .cent_os => "CENTOS",
            .oracle_linux => "ORACLE_LINUX",
            .debian => "DEBIAN",
            .mac_os => "MACOS",
            .raspbian => "RASPBIAN",
            .rocky_linux => "ROCKY_LINUX",
            .alma_linux => "ALMA_LINUX",
            .amazon_linux_2023 => "AMAZON_LINUX_2023",
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
