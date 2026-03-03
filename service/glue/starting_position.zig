const std = @import("std");

pub const StartingPosition = enum {
    latest,
    trim_horizon,
    earliest,
    timestamp,

    pub const json_field_names = .{
        .latest = "latest",
        .trim_horizon = "trim_horizon",
        .earliest = "earliest",
        .timestamp = "timestamp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .latest => "latest",
            .trim_horizon => "trim_horizon",
            .earliest => "earliest",
            .timestamp => "timestamp",
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
