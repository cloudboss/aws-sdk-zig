const std = @import("std");

pub const AnalyticsSessionMetricName = enum {
    count,
    success,
    failure,
    dropped,
    duration,
    turns_per_conversation,
    concurrency,

    pub const json_field_names = .{
        .count = "Count",
        .success = "Success",
        .failure = "Failure",
        .dropped = "Dropped",
        .duration = "Duration",
        .turns_per_conversation = "TurnsPerConversation",
        .concurrency = "Concurrency",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .count => "Count",
            .success => "Success",
            .failure => "Failure",
            .dropped => "Dropped",
            .duration => "Duration",
            .turns_per_conversation => "TurnsPerConversation",
            .concurrency => "Concurrency",
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
