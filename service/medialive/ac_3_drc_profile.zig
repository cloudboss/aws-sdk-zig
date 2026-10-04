const std = @import("std");

/// Ac3 Drc Profile
pub const Ac3DrcProfile = enum {
    film_standard,
    none,

    pub const json_field_names = .{
        .film_standard = "FILM_STANDARD",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .film_standard => "FILM_STANDARD",
            .none => "NONE",
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
