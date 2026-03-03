const std = @import("std");

/// Specify how you want MediaConvert to determine the fragment length. Choose
/// Exact to have the encoder use the exact length that you specify with the
/// setting Fragment length. This might result in extra I-frames. Choose
/// Multiple of GOP to have the encoder round up the segment lengths to match
/// the next GOP boundary.
pub const MsSmoothFragmentLengthControl = enum {
    exact,
    gop_multiple,

    pub const json_field_names = .{
        .exact = "EXACT",
        .gop_multiple = "GOP_MULTIPLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exact => "EXACT",
            .gop_multiple => "GOP_MULTIPLE",
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
