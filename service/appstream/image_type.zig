const std = @import("std");

/// The image type is the type of AppStream image resource.
pub const ImageType = enum {
    custom,
    native,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .native = "NATIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .native => "NATIVE",
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
