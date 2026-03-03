const std = @import("std");

/// Choose the presentation style of your input SCC captions. To use the same
/// presentation style as your input: Keep the default value, Disabled. To
/// convert paint-on captions to pop-on: Choose Enabled. We also recommend that
/// you choose Enabled if you notice additional repeated lines in your output
/// captions.
pub const CaptionSourceConvertPaintOnToPopOn = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "ENABLED",
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
