const std = @import("std");

pub const ConnectorOperationStepType = enum {
    initialize_update,
    finalize_update,
    update_worker_setting,
    update_connector_configuration,
    validate_update,

    pub const json_field_names = .{
        .initialize_update = "INITIALIZE_UPDATE",
        .finalize_update = "FINALIZE_UPDATE",
        .update_worker_setting = "UPDATE_WORKER_SETTING",
        .update_connector_configuration = "UPDATE_CONNECTOR_CONFIGURATION",
        .validate_update = "VALIDATE_UPDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialize_update => "INITIALIZE_UPDATE",
            .finalize_update => "FINALIZE_UPDATE",
            .update_worker_setting => "UPDATE_WORKER_SETTING",
            .update_connector_configuration => "UPDATE_CONNECTOR_CONFIGURATION",
            .validate_update => "VALIDATE_UPDATE",
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
