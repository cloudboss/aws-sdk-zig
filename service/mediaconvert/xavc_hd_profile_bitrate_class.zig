const std = @import("std");

/// Specify the XAVC HD (Long GOP) Bitrate Class to set the bitrate of your
/// output. Outputs of the same class have similar image quality over the
/// operating points that are valid for that class.
pub const XavcHdProfileBitrateClass = enum {
    bitrate_class_25,
    bitrate_class_35,
    bitrate_class_50,

    pub const json_field_names = .{
        .bitrate_class_25 = "BITRATE_CLASS_25",
        .bitrate_class_35 = "BITRATE_CLASS_35",
        .bitrate_class_50 = "BITRATE_CLASS_50",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bitrate_class_25 => "BITRATE_CLASS_25",
            .bitrate_class_35 => "BITRATE_CLASS_35",
            .bitrate_class_50 => "BITRATE_CLASS_50",
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
