const std = @import("std");

pub const ApplicationProtocol = enum {
    secure_mqtt,
    mqtt_wss,
    https,
    default,

    pub const json_field_names = .{
        .secure_mqtt = "SECURE_MQTT",
        .mqtt_wss = "MQTT_WSS",
        .https = "HTTPS",
        .default = "DEFAULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .secure_mqtt => "SECURE_MQTT",
            .mqtt_wss => "MQTT_WSS",
            .https => "HTTPS",
            .default => "DEFAULT",
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
