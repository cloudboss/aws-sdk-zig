const std = @import("std");

/// The codec to use on the video that the device produces.
pub const InputDeviceCodec = enum {
    hevc,
    avc,

    pub const json_field_names = .{
        .hevc = "HEVC",
        .avc = "AVC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hevc => "HEVC",
            .avc => "AVC",
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
