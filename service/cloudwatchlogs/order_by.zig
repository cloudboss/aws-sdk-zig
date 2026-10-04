const std = @import("std");

pub const OrderBy = enum {
    log_stream_name,
    last_event_time,

    pub const json_field_names = .{
        .log_stream_name = "LogStreamName",
        .last_event_time = "LastEventTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log_stream_name => "LogStreamName",
            .last_event_time => "LastEventTime",
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
