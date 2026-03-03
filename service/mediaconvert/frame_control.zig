const std = @import("std");

/// Choose how MediaConvert handles start and end times for input clipping with
/// video passthrough. Your input video codec must be H.264 or H.265 to use
/// IFRAME. To clip at the nearest IDR-frame: Choose Nearest IDR. If an
/// IDR-frame is not found at the frame that you specify, MediaConvert uses the
/// next compatible IDR-frame. Note that your output may be shorter than your
/// input clip duration. To clip at the nearest I-frame: Choose Nearest I-frame.
/// If an I-frame is not found at the frame that you specify, MediaConvert uses
/// the next compatible I-frame. Note that your output may be shorter than your
/// input clip duration. We only recommend this setting for special workflows,
/// and when you choose this setting your output may not be compatible with most
/// players.
pub const FrameControl = enum {
    nearest_idrframe,
    nearest_iframe,

    pub const json_field_names = .{
        .nearest_idrframe = "NEAREST_IDRFRAME",
        .nearest_iframe = "NEAREST_IFRAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nearest_idrframe => "NEAREST_IDRFRAME",
            .nearest_iframe => "NEAREST_IFRAME",
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
