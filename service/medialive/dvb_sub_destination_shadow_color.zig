const std = @import("std");

/// Dvb Sub Destination Shadow Color
pub const DvbSubDestinationShadowColor = enum {
    black,
    none,
    white,

    pub const json_field_names = .{
        .black = "BLACK",
        .none = "NONE",
        .white = "WHITE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .black => "BLACK",
            .none => "NONE",
            .white => "WHITE",
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
