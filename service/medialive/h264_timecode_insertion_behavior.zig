const std = @import("std");

/// H264 Timecode Insertion Behavior
pub const H264TimecodeInsertionBehavior = enum {
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
