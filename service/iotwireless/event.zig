const std = @import("std");

/// Sidewalk device status notification.
pub const Event = enum {
    discovered,
    lost,
    ack,
    nack,
    passthrough,

    pub const json_field_names = .{
        .discovered = "discovered",
        .lost = "lost",
        .ack = "ack",
        .nack = "nack",
        .passthrough = "passthrough",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .discovered => "discovered",
            .lost => "lost",
            .ack => "ack",
            .nack => "nack",
            .passthrough => "passthrough",
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
