const std = @import("std");

/// Includes or excludes EXT-X-PROGRAM-DATE-TIME tag in .m3u8 manifest files.
/// The value is calculated as follows: either the program date and time are
/// initialized using the input timecode source, or the time is initialized
/// using the input timecode source and the date is initialized using the
/// timestamp_offset.
pub const HlsProgramDateTime = enum {
    include,
    exclude,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .exclude = "EXCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
            .exclude => "EXCLUDE",
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
