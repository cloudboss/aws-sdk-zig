const std = @import("std");

pub const MaintenanceType = enum {
    reboot_node,
    restart_search_process,
    restart_dashboard,

    pub const json_field_names = .{
        .reboot_node = "REBOOT_NODE",
        .restart_search_process = "RESTART_SEARCH_PROCESS",
        .restart_dashboard = "RESTART_DASHBOARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .reboot_node => "REBOOT_NODE",
            .restart_search_process => "RESTART_SEARCH_PROCESS",
            .restart_dashboard => "RESTART_DASHBOARD",
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
