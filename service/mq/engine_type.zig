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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
