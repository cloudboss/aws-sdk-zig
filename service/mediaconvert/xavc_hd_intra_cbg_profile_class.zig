const std = @import("std");

/// Specify the XAVC Intra HD (CBG) Class to set the bitrate of your output.
/// Outputs of the same class have similar image quality over the operating
/// points that are valid for that class.
pub const XavcHdIntraCbgProfileClass = enum {
    class_50,
    class_100,
    class_200,

    pub const json_field_names = .{
        .class_50 = "CLASS_50",
        .class_100 = "CLASS_100",
        .class_200 = "CLASS_200",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .class_50 => "CLASS_50",
            .class_100 => "CLASS_100",
            .class_200 => "CLASS_200",
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
