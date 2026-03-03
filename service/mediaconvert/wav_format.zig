const std = @import("std");

/// Specify the file format for your wave audio output. To use a RIFF wave
/// format: Keep the default value, RIFF. If your output audio is likely to
/// exceed 4GB in file size, or if you otherwise need the extended support of
/// the RF64 format: Choose RF64. If your player only supports the extensible
/// wave format: Choose Extensible.
pub const WavFormat = enum {
    riff,
    rf64,
    extensible,

    pub const json_field_names = .{
        .riff = "RIFF",
        .rf64 = "RF64",
        .extensible = "EXTENSIBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .riff => "RIFF",
            .rf64 => "RF64",
            .extensible => "EXTENSIBLE",
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
