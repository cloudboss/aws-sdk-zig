const std = @import("std");

/// Use Level to set the MPEG-2 level for the video output.
pub const Mpeg2CodecLevel = enum {
    auto,
    low,
    main,
    high1440,
    high,

    pub const json_field_names = .{
        .auto = "AUTO",
        .low = "LOW",
        .main = "MAIN",
        .high1440 = "HIGH1440",
        .high = "HIGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .low => "LOW",
            .main => "MAIN",
            .high1440 => "HIGH1440",
            .high => "HIGH",
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
