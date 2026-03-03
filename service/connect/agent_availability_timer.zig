const std = @import("std");

pub const AgentAvailabilityTimer = enum {
    time_since_last_activity,
    time_since_last_inbound,

    pub const json_field_names = .{
        .time_since_last_activity = "TIME_SINCE_LAST_ACTIVITY",
        .time_since_last_inbound = "TIME_SINCE_LAST_INBOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .time_since_last_activity => "TIME_SINCE_LAST_ACTIVITY",
            .time_since_last_inbound => "TIME_SINCE_LAST_INBOUND",
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
