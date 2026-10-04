const std = @import("std");

/// Ab Watermarker Id Length
pub const AbWatermarkerIdLength = enum {
    id_2048,
    id_512,

    pub const json_field_names = .{
        .id_2048 = "ID_2048",
        .id_512 = "ID_512",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .id_2048 => "ID_2048",
            .id_512 => "ID_512",
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
