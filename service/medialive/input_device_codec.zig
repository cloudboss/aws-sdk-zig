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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
