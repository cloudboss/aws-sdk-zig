const std = @import("std");

/// M2ts Segmentation Style
pub const M2tsSegmentationStyle = enum {
    maintain_cadence,
    reset_cadence,

    pub const json_field_names = .{
        .maintain_cadence = "MAINTAIN_CADENCE",
        .reset_cadence = "RESET_CADENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .maintain_cadence => "MAINTAIN_CADENCE",
            .reset_cadence => "RESET_CADENCE",
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
