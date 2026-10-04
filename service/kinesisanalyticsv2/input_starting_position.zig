const std = @import("std");

pub const InputStartingPosition = enum {
    now,
    trim_horizon,
    last_stopped_point,

    pub const json_field_names = .{
        .now = "NOW",
        .trim_horizon = "TRIM_HORIZON",
        .last_stopped_point = "LAST_STOPPED_POINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .now => "NOW",
            .trim_horizon => "TRIM_HORIZON",
            .last_stopped_point => "LAST_STOPPED_POINT",
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
