const std = @import("std");

pub const Protocol = enum {
    mqtt_v3_1_1,
    mqtt_v5,
    mqtt_v3_1_1_over_web_socket,
    mqtt_v5_over_web_socket,

    pub const json_field_names = .{
        .mqtt_v3_1_1 = "MqttV3_1_1",
        .mqtt_v5 = "MqttV5",
        .mqtt_v3_1_1_over_web_socket = "MqttV3_1_1_OverWebSocket",
        .mqtt_v5_over_web_socket = "MqttV5_OverWebSocket",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mqtt_v3_1_1 => "MqttV3_1_1",
            .mqtt_v5 => "MqttV5",
            .mqtt_v3_1_1_over_web_socket => "MqttV3_1_1_OverWebSocket",
            .mqtt_v5_over_web_socket => "MqttV5_OverWebSocket",
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
