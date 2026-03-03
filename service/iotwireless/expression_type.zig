const std = @import("std");

pub const ExpressionType = enum {
    rule_name,
    mqtt_topic,

    pub const json_field_names = .{
        .rule_name = "RuleName",
        .mqtt_topic = "MqttTopic",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rule_name => "RuleName",
            .mqtt_topic => "MqttTopic",
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
