const std = @import("std");

pub const TrafficRoutingConfigType = enum {
    all_at_once,
    canary,
    linear,

    pub const json_field_names = .{
        .all_at_once = "ALL_AT_ONCE",
        .canary = "CANARY",
        .linear = "LINEAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_at_once => "ALL_AT_ONCE",
            .canary => "CANARY",
            .linear => "LINEAR",
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
