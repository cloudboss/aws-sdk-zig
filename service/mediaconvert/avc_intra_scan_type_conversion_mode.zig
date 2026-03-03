const std = @import("std");

/// Use this setting for interlaced outputs, when your output frame rate is half
/// of your input frame rate. In this situation, choose Optimized interlacing to
/// create a better quality interlaced output. In this case, each progressive
/// frame from the input corresponds to an interlaced field in the output. Keep
/// the default value, Basic interlacing, for all other output frame rates. With
/// basic interlacing, MediaConvert performs any frame rate conversion first and
/// then interlaces the frames. When you choose Optimized interlacing and you
/// set your output frame rate to a value that isn't suitable for optimized
/// interlacing, MediaConvert automatically falls back to basic interlacing.
/// Required settings: To use optimized interlacing, you must set Telecine to
/// None or Soft. You can't use optimized interlacing for hard telecine outputs.
/// You must also set Interlace mode to a value other than Progressive.
pub const AvcIntraScanTypeConversionMode = enum {
    interlaced,
    interlaced_optimize,

    pub const json_field_names = .{
        .interlaced = "INTERLACED",
        .interlaced_optimize = "INTERLACED_OPTIMIZE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .interlaced => "INTERLACED",
            .interlaced_optimize => "INTERLACED_OPTIMIZE",
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
