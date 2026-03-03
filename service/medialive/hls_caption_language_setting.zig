const std = @import("std");

/// Hls Caption Language Setting
pub const HlsCaptionLanguageSetting = enum {
    insert,
    none,
    omit,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
        .omit = "OMIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
            .none => "NONE",
            .omit => "OMIT",
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
