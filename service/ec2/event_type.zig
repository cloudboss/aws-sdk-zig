const std = @import("std");

pub const EventType = enum {
    instance_change,
    batch_change,
    @"error",
    information,

    pub const json_field_names = .{
        .instance_change = "instanceChange",
        .batch_change = "fleetRequestChange",
        .@"error" = "error",
        .information = "information",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_change => "instanceChange",
            .batch_change => "fleetRequestChange",
            .@"error" => "error",
            .information => "information",
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
