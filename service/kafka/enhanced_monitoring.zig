const std = @import("std");

/// Specifies which metrics are gathered for the MSK cluster. This property has
/// the following possible values: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER,
/// and PER_TOPIC_PER_PARTITION. For a list of the metrics associated with each
/// of these levels of monitoring, see
/// [Monitoring](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html).
pub const EnhancedMonitoring = enum {
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
