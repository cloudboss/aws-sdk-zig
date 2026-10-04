const std = @import("std");

/// The type of broker engine. Amazon MQ supports ActiveMQ and RabbitMQ.
pub const EngineType = enum {
    activemq,
    rabbitmq,

    pub const json_field_names = .{
        .activemq = "ACTIVEMQ",
        .rabbitmq = "RABBITMQ",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activemq => "ACTIVEMQ",
            .rabbitmq => "RABBITMQ",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
