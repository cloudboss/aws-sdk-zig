const std = @import("std");

/// Maximum framerate in frames per second (Outputs only)
pub const ReservationMaximumFramerate = enum {
    max_30_fps,
    max_60_fps,

    pub const json_field_names = .{
        .max_30_fps = "MAX_30_FPS",
        .max_60_fps = "MAX_60_FPS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_30_fps => "MAX_30_FPS",
            .max_60_fps => "MAX_60_FPS",
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
