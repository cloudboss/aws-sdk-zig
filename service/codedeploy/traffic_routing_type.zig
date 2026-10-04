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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
