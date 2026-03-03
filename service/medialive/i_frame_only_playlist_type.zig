const std = @import("std");

/// When set to "standard", an I-Frame only playlist will be written out for
/// each video output in the output group. This I-Frame only playlist will
/// contain byte range offsets pointing to the I-frame(s) in each segment.
pub const IFrameOnlyPlaylistType = enum {
    disabled,
    standard,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .standard = "STANDARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .standard => "STANDARD",
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
