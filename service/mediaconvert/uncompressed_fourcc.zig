const std = @import("std");

/// The four character code for the uncompressed video.
pub const UncompressedFourcc = enum {
    i420,
    i422,
    i444,

    pub const json_field_names = .{
        .i420 = "I420",
        .i422 = "I422",
        .i444 = "I444",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .i420 => "I420",
            .i422 => "I422",
            .i444 => "I444",
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
