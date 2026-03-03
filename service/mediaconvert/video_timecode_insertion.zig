const std = @import("std");

/// Applies only to H.264, H.265, MPEG2, and ProRes outputs. Only enable
/// Timecode insertion when the input frame rate is identical to the output
/// frame rate. To include timecodes in this output, set Timecode insertion to
/// PIC_TIMING_SEI. To leave them out, set it to DISABLED. Default is DISABLED.
/// When the service inserts timecodes in an output, by default, it uses any
/// embedded timecodes from the input. If none are present, the service will set
/// the timecode for the first output frame to zero. To change this default
/// behavior, adjust the settings under Timecode configuration. In the console,
/// these settings are located under Job > Job settings > Timecode
/// configuration. Note - Timecode source under input settings does not affect
/// the timecodes that are inserted in the output. Source under Job settings >
/// Timecode configuration does.
pub const VideoTimecodeInsertion = enum {
    disabled,
    pic_timing_sei,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .pic_timing_sei = "PIC_TIMING_SEI",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .pic_timing_sei => "PIC_TIMING_SEI",
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
