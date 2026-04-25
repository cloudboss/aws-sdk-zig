const std = @import("std");

pub const LogType = enum {
    system_logs,
    application_logs,
    persistent_ui_logs,

    pub const json_field_names = .{
        .system_logs = "system-logs",
        .application_logs = "application-logs",
        .persistent_ui_logs = "persistent-ui-logs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .system_logs => "system-logs",
            .application_logs => "application-logs",
            .persistent_ui_logs => "persistent-ui-logs",
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
