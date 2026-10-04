const std = @import("std");

/// Set to "padded" to force MediaConvert to add padding to the frame, to obtain
/// a frame that is a whole multiple of the tile size. If you are setting up the
/// picture as a tile, you must enter "padded". In all other configurations, you
/// typically enter "none".
pub const H265TilePadding = enum {
    none,
    padded,

    pub const json_field_names = .{
        .none = "NONE",
        .padded = "PADDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .padded => "PADDED",
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
