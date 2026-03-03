const std = @import("std");

pub const VoiceConnectorIntegrationType = enum {
    connect_call_transfer_connector,
    connect_analytics_connector,

    pub const json_field_names = .{
        .connect_call_transfer_connector = "CONNECT_CALL_TRANSFER_CONNECTOR",
        .connect_analytics_connector = "CONNECT_ANALYTICS_CONNECTOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .connect_call_transfer_connector => "CONNECT_CALL_TRANSFER_CONNECTOR",
            .connect_analytics_connector => "CONNECT_ANALYTICS_CONNECTOR",
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
