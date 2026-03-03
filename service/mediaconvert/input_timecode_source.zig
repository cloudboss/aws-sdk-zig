const std = @import("std");

/// Use this Timecode source setting, located under the input settings, to
/// specify how the service counts input video frames. This input frame count
/// affects only the behavior of features that apply to a single input at a
/// time, such as input clipping and synchronizing some captions formats. Choose
/// Embedded to use the timecodes in your input video. Choose Start at zero to
/// start the first frame at zero. Choose Specified start to start the first
/// frame at the timecode that you specify in the setting Start timecode. If you
/// don't specify a value for Timecode source, the service will use Embedded by
/// default. For more information about timecodes, see
/// https://docs.aws.amazon.com/console/mediaconvert/timecode.
pub const InputTimecodeSource = enum {
    embedded,
    zerobased,
    specifiedstart,

    pub const json_field_names = .{
        .embedded = "EMBEDDED",
        .zerobased = "ZEROBASED",
        .specifiedstart = "SPECIFIEDSTART",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .embedded => "EMBEDDED",
            .zerobased => "ZEROBASED",
            .specifiedstart => "SPECIFIEDSTART",
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
