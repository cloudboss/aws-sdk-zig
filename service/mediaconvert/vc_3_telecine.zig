const std = @import("std");

/// When you do frame rate conversion from 23.976 frames per second (fps) to
/// 29.97 fps, and your output scan type is interlaced, you can optionally
/// enable hard telecine to create a smoother picture. When you keep the default
/// value, None, MediaConvert does a standard frame rate conversion to 29.97
/// without doing anything with the field polarity to create a smoother picture.
pub const Vc3Telecine = enum {
    none,
    hard,

    pub const json_field_names = .{
        .none = "NONE",
        .hard = "HARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .hard => "HARD",
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
