const std = @import("std");

pub const TrafficRoutingType = enum {
    time_based_canary,
    time_based_linear,
    all_at_once,

    pub const json_field_names = .{
        .time_based_canary = "TimeBasedCanary",
        .time_based_linear = "TimeBasedLinear",
        .all_at_once = "AllAtOnce",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .time_based_canary => "TimeBasedCanary",
            .time_based_linear => "TimeBasedLinear",
            .all_at_once => "AllAtOnce",
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
