const std = @import("std");

/// Sidewalk device message type. Default value is
/// `CUSTOM_COMMAND_ID_NOTIFY`.
pub const MessageType = enum {
    custom_command_id_notify,
    custom_command_id_get,
    custom_command_id_set,
    custom_command_id_resp,

    pub const json_field_names = .{
        .custom_command_id_notify = "CUSTOM_COMMAND_ID_NOTIFY",
        .custom_command_id_get = "CUSTOM_COMMAND_ID_GET",
        .custom_command_id_set = "CUSTOM_COMMAND_ID_SET",
        .custom_command_id_resp = "CUSTOM_COMMAND_ID_RESP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom_command_id_notify => "CUSTOM_COMMAND_ID_NOTIFY",
            .custom_command_id_get => "CUSTOM_COMMAND_ID_GET",
            .custom_command_id_set => "CUSTOM_COMMAND_ID_SET",
            .custom_command_id_resp => "CUSTOM_COMMAND_ID_RESP",
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
