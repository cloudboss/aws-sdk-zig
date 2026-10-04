const std = @import("std");

pub const ListInsightsDataDimensionKey = enum {
    event_id,
    event_name,
    event_source,

    pub const json_field_names = .{
        .event_id = "EventId",
        .event_name = "EventName",
        .event_source = "EventSource",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_id => "EventId",
            .event_name => "EventName",
            .event_source => "EventSource",
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
