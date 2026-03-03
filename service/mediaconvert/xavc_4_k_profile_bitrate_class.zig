const std = @import("std");

/// Specify the XAVC 4k (Long GOP) Bitrate Class to set the bitrate of your
/// output. Outputs of the same class have similar image quality over the
/// operating points that are valid for that class.
pub const Xavc4kProfileBitrateClass = enum {
    bitrate_class_100,
    bitrate_class_140,
    bitrate_class_200,

    pub const json_field_names = .{
        .bitrate_class_100 = "BITRATE_CLASS_100",
        .bitrate_class_140 = "BITRATE_CLASS_140",
        .bitrate_class_200 = "BITRATE_CLASS_200",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bitrate_class_100 => "BITRATE_CLASS_100",
            .bitrate_class_140 => "BITRATE_CLASS_140",
            .bitrate_class_200 => "BITRATE_CLASS_200",
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
