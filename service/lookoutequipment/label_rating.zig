const std = @import("std");

pub const LabelRating = enum {
    anomaly,
    no_anomaly,
    neutral,

    pub const json_field_names = .{
        .anomaly = "ANOMALY",
        .no_anomaly = "NO_ANOMALY",
        .neutral = "NEUTRAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .anomaly => "ANOMALY",
            .no_anomaly => "NO_ANOMALY",
            .neutral => "NEUTRAL",
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
