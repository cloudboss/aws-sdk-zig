const std = @import("std");

/// The image type is the type of AppStream image resource.
pub const ImageType = enum {
    custom,
    native,
    byol,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .native = "NATIVE",
        .byol = "BYOL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .custom => "CUSTOM",
            .native => "NATIVE",
            .byol => "BYOL",
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
