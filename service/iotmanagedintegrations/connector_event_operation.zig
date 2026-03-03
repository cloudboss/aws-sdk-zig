const std = @import("std");

pub const ConnectorEventOperation = enum {
    device_command_response,
    device_discovery,
    device_event,
    device_command_request,

    pub const json_field_names = .{
        .device_command_response = "DEVICE_COMMAND_RESPONSE",
        .device_discovery = "DEVICE_DISCOVERY",
        .device_event = "DEVICE_EVENT",
        .device_command_request = "DEVICE_COMMAND_REQUEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device_command_response => "DEVICE_COMMAND_RESPONSE",
            .device_discovery => "DEVICE_DISCOVERY",
            .device_event => "DEVICE_EVENT",
            .device_command_request => "DEVICE_COMMAND_REQUEST",
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
