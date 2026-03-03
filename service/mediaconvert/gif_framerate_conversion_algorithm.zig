const std = @import("std");

/// Optional. Specify how the transcoder performs framerate conversion. The
/// default behavior is to use Drop duplicate (DUPLICATE_DROP) conversion. When
/// you choose Interpolate (INTERPOLATE) instead, the conversion produces
/// smoother motion.
pub const GifFramerateConversionAlgorithm = enum {
    duplicate_drop,
    interpolate,

    pub const json_field_names = .{
        .duplicate_drop = "DUPLICATE_DROP",
        .interpolate = "INTERPOLATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_drop => "DUPLICATE_DROP",
            .interpolate => "INTERPOLATE",
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
