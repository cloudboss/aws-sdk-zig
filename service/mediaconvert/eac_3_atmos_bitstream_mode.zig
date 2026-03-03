const std = @import("std");

/// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
/// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
/// E).
pub const Eac3AtmosBitstreamMode = enum {
    complete_main,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete_main => "COMPLETE_MAIN",
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
