const std = @import("std");

/// Specify whether this set of input captions appears in your outputs in both
/// 608 and 708 format. If you choose Upconvert, MediaConvert includes the
/// captions data in two ways: it passes the 608 data through using the 608
/// compatibility bytes fields of the 708 wrapper, and it also translates the
/// 608 data into 708.
pub const FileSourceConvert608To708 = enum {
    upconvert,
    disabled,

    pub const json_field_names = .{
        .upconvert = "UPCONVERT",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .upconvert => "UPCONVERT",
            .disabled => "DISABLED",
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
