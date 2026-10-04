const std = @import("std");

/// codec in increasing order of complexity
pub const InputCodec = enum {
    mpeg2,
    avc,
    hevc,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .avc = "AVC",
        .hevc = "HEVC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mpeg2 => "MPEG2",
            .avc => "AVC",
            .hevc => "HEVC",
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
