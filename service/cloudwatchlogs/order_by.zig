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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
