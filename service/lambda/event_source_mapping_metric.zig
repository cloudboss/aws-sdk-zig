const std = @import("std");

pub const EventSourceMappingMetric = enum {
    event_count,
    error_count,
    kafka_metrics,

    pub const json_field_names = .{
        .event_count = "EventCount",
        .error_count = "ErrorCount",
        .kafka_metrics = "KafkaMetrics",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_count => "EventCount",
            .error_count => "ErrorCount",
            .kafka_metrics => "KafkaMetrics",
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
