const std = @import("std");

/// Specify the codec profile for this output. Choose High, 8-bit, 4:2:0 (HIGH)
/// or High, 10-bit, 4:2:2 (HIGH_422). These profiles are specified in ITU-T
/// H.264.
pub const Xavc4kProfileCodecProfile = enum {
    high,
    high_422,

    pub const json_field_names = .{
        .high = "HIGH",
        .high_422 = "HIGH_422",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .high => "HIGH",
            .high_422 => "HIGH_422",
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
