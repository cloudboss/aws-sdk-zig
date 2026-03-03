const std = @import("std");

/// This field applies only if the Streams > Advanced > Framerate field is set
/// to 29.970. This field works with the Streams > Advanced > Preprocessors >
/// Deinterlacer field and the Streams > Advanced > Interlaced Mode field to
/// identify the scan type for the output: Progressive, Interlaced, Hard
/// Telecine or Soft Telecine. - Hard: produces 29.97i output from 23.976 input.
/// - Soft: produces 23.976; the player converts this output to 29.97i.
pub const H265Telecine = enum {
    none,
    soft,
    hard,

    pub const json_field_names = .{
        .none = "NONE",
        .soft = "SOFT",
        .hard = "HARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .soft => "SOFT",
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
