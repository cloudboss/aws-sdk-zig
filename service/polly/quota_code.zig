const std = @import("std");

pub const QuotaCode = enum {
    input_stream_inbound_event_timeout,
    input_stream_timeout,

    pub const json_field_names = .{
        .input_stream_inbound_event_timeout = "input-stream-inbound-event-timeout",
        .input_stream_timeout = "input-stream-timeout",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input_stream_inbound_event_timeout => "input-stream-inbound-event-timeout",
            .input_stream_timeout => "input-stream-timeout",
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
