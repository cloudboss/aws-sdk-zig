const std = @import("std");

pub const ConnectorOperationType = enum {
    update_worker_setting,
    update_connector_configuration,
    isolate_connector,
    restore_connector,

    pub const json_field_names = .{
        .update_worker_setting = "UPDATE_WORKER_SETTING",
        .update_connector_configuration = "UPDATE_CONNECTOR_CONFIGURATION",
        .isolate_connector = "ISOLATE_CONNECTOR",
        .restore_connector = "RESTORE_CONNECTOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .update_worker_setting => "UPDATE_WORKER_SETTING",
            .update_connector_configuration => "UPDATE_CONNECTOR_CONFIGURATION",
            .isolate_connector => "ISOLATE_CONNECTOR",
            .restore_connector => "RESTORE_CONNECTOR",
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
