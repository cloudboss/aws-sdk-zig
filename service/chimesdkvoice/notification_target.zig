const std = @import("std");

pub const NotificationTarget = enum {
    event_bridge,
    sns,
    sqs,

    pub const json_field_names = .{
        .event_bridge = "EventBridge",
        .sns = "SNS",
        .sqs = "SQS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_bridge => "EventBridge",
            .sns => "SNS",
            .sqs => "SQS",
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
