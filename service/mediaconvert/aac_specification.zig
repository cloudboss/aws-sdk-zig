const std = @import("std");

/// Use MPEG-2 AAC instead of MPEG-4 AAC audio for raw or MPEG-2 Transport
/// Stream containers.
pub const AacSpecification = enum {
    mpeg2,
    mpeg4,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .mpeg4 = "MPEG4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mpeg2 => "MPEG2",
            .mpeg4 => "MPEG4",
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
