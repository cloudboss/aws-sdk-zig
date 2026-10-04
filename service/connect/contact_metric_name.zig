const std = @import("std");

pub const ContactMetricName = enum {
    estimated_wait_time,
    position_in_queue,

    pub const json_field_names = .{
        .estimated_wait_time = "ESTIMATED_WAIT_TIME",
        .position_in_queue = "POSITION_IN_QUEUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .estimated_wait_time => "ESTIMATED_WAIT_TIME",
            .position_in_queue => "POSITION_IN_QUEUE",
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
