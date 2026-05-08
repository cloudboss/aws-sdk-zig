const std = @import("std");

/// Enumeration of supported enhanced monitoring levels for Amazon MSK clusters:
/// DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER, and PER_TOPIC_PER_PARTITION.
pub const MskEnhancedMonitoringLevel = enum {
    default,
    per_broker,
    per_topic_per_broker,
    per_topic_per_partition,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .per_broker = "PER_BROKER",
        .per_topic_per_broker = "PER_TOPIC_PER_BROKER",
        .per_topic_per_partition = "PER_TOPIC_PER_PARTITION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .per_broker => "PER_BROKER",
            .per_topic_per_broker => "PER_TOPIC_PER_BROKER",
            .per_topic_per_partition => "PER_TOPIC_PER_PARTITION",
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
