const std = @import("std");

/// The type of the input device. For an AWS Elemental Link device that outputs
/// resolutions up to 1080, choose "HD".
pub const InputDeviceType = enum {
    hd,
    uhd,

    pub const json_field_names = .{
        .hd = "HD",
        .uhd = "UHD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hd => "HD",
            .uhd => "UHD",
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
