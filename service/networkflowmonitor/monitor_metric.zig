const std = @import("std");

pub const MonitorMetric = enum {
    round_trip_time,
    timeouts,
    retransmissions,
    data_transferred,

    pub const json_field_names = .{
        .round_trip_time = "ROUND_TRIP_TIME",
        .timeouts = "TIMEOUTS",
        .retransmissions = "RETRANSMISSIONS",
        .data_transferred = "DATA_TRANSFERRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .round_trip_time => "ROUND_TRIP_TIME",
            .timeouts => "TIMEOUTS",
            .retransmissions => "RETRANSMISSIONS",
            .data_transferred => "DATA_TRANSFERRED",
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
