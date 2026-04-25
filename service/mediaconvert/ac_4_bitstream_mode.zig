const std = @import("std");

/// Specify the bitstream mode for the AC-4 stream that the encoder emits. For
/// more information about the AC-4 bitstream mode, see ETSI TS 103 190. Maps to
/// dlb_paec_ac4_bed_classifier in the encoder implementation. - COMPLETE_MAIN:
/// Complete Main (standard mix) - EMERGENCY: Stereo Emergency content
pub const Ac4BitstreamMode = enum {
    complete_main,
    emergency,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
        .emergency = "EMERGENCY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete_main => "COMPLETE_MAIN",
            .emergency => "EMERGENCY",
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
