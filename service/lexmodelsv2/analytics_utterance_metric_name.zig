const std = @import("std");

pub const AnalyticsUtteranceMetricName = enum {
    count,
    missed,
    detected,
    utterance_timestamp,

    pub const json_field_names = .{
        .count = "Count",
        .missed = "Missed",
        .detected = "Detected",
        .utterance_timestamp = "UtteranceTimestamp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "Count",
            .missed => "Missed",
            .detected => "Detected",
            .utterance_timestamp => "UtteranceTimestamp",
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
