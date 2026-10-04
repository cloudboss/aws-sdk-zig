const std = @import("std");

/// Specify the XAVC Intra 4k (CBG) Class to set the bitrate of your output.
/// Outputs of the same class have similar image quality over the operating
/// points that are valid for that class.
pub const Xavc4kIntraCbgProfileClass = enum {
    class_100,
    class_300,
    class_480,

    pub const json_field_names = .{
        .class_100 = "CLASS_100",
        .class_300 = "CLASS_300",
        .class_480 = "CLASS_480",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .class_100 => "CLASS_100",
            .class_300 => "CLASS_300",
            .class_480 => "CLASS_480",
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
