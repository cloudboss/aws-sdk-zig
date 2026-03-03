const std = @import("std");

pub const CapacityReservationInstancePlatform = enum {
    linux_unix,
    red_hat_enterprise_linux,
    suse_linux,
    windows,
    windows_with_sql_server,
    windows_with_sql_server_enterprise,
    windows_with_sql_server_standard,
    windows_with_sql_server_web,
    linux_with_sql_server_standard,
    linux_with_sql_server_web,
    linux_with_sql_server_enterprise,
    rhel_with_sql_server_standard,
    rhel_with_sql_server_enterprise,
    rhel_with_sql_server_web,
    rhel_with_ha,
    rhel_with_ha_and_sql_server_standard,
    rhel_with_ha_and_sql_server_enterprise,
    ubuntu_pro_linux,

    pub const json_field_names = .{
        .linux_unix = "Linux/UNIX",
        .red_hat_enterprise_linux = "Red Hat Enterprise Linux",
        .suse_linux = "SUSE Linux",
        .windows = "Windows",
        .windows_with_sql_server = "Windows with SQL Server",
        .windows_with_sql_server_enterprise = "Windows with SQL Server Enterprise",
        .windows_with_sql_server_standard = "Windows with SQL Server Standard",
        .windows_with_sql_server_web = "Windows with SQL Server Web",
        .linux_with_sql_server_standard = "Linux with SQL Server Standard",
        .linux_with_sql_server_web = "Linux with SQL Server Web",
        .linux_with_sql_server_enterprise = "Linux with SQL Server Enterprise",
        .rhel_with_sql_server_standard = "RHEL with SQL Server Standard",
        .rhel_with_sql_server_enterprise = "RHEL with SQL Server Enterprise",
        .rhel_with_sql_server_web = "RHEL with SQL Server Web",
        .rhel_with_ha = "RHEL with HA",
        .rhel_with_ha_and_sql_server_standard = "RHEL with HA and SQL Server Standard",
        .rhel_with_ha_and_sql_server_enterprise = "RHEL with HA and SQL Server Enterprise",
        .ubuntu_pro_linux = "Ubuntu Pro",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linux_unix => "Linux/UNIX",
            .red_hat_enterprise_linux => "Red Hat Enterprise Linux",
            .suse_linux => "SUSE Linux",
            .windows => "Windows",
            .windows_with_sql_server => "Windows with SQL Server",
            .windows_with_sql_server_enterprise => "Windows with SQL Server Enterprise",
            .windows_with_sql_server_standard => "Windows with SQL Server Standard",
            .windows_with_sql_server_web => "Windows with SQL Server Web",
            .linux_with_sql_server_standard => "Linux with SQL Server Standard",
            .linux_with_sql_server_web => "Linux with SQL Server Web",
            .linux_with_sql_server_enterprise => "Linux with SQL Server Enterprise",
            .rhel_with_sql_server_standard => "RHEL with SQL Server Standard",
            .rhel_with_sql_server_enterprise => "RHEL with SQL Server Enterprise",
            .rhel_with_sql_server_web => "RHEL with SQL Server Web",
            .rhel_with_ha => "RHEL with HA",
            .rhel_with_ha_and_sql_server_standard => "RHEL with HA and SQL Server Standard",
            .rhel_with_ha_and_sql_server_enterprise => "RHEL with HA and SQL Server Enterprise",
            .ubuntu_pro_linux => "Ubuntu Pro",
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
