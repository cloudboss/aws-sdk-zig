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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
