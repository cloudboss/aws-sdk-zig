const std = @import("std");

/// If you specify a StopTimecode in an input (in order to clip the file), you
/// can specify if you want the clip to exclude (the default) or include the
/// frame specified by the timecode.
pub const LastFrameClippingBehavior = enum {
    exclude_last_frame,
    include_last_frame,

    pub const json_field_names = .{
        .exclude_last_frame = "EXCLUDE_LAST_FRAME",
        .include_last_frame = "INCLUDE_LAST_FRAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exclude_last_frame => "EXCLUDE_LAST_FRAME",
            .include_last_frame => "INCLUDE_LAST_FRAME",
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
