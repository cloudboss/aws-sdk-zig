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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
