const std = @import("std");

pub const OutputTimestampMode = enum {
    passthrough,
    rebased_to_channel_start,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .rebased_to_channel_start = "REBASED_TO_CHANNEL_START",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .rebased_to_channel_start => "REBASED_TO_CHANNEL_START",
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
