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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
