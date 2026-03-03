const std = @import("std");

/// Optionally include or suppress markers at the end of your output that signal
/// the end of the video stream. To include end of stream markers: Leave blank
/// or keep the default value, Include. To not include end of stream markers:
/// Choose Suppress. This is useful when your output will be inserted into
/// another stream.
pub const H265EndOfStreamMarkers = enum {
    include,
    suppress,

    pub const json_field_names = .{
        .include = "INCLUDE",
        .suppress = "SUPPRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .include => "INCLUDE",
            .suppress => "SUPPRESS",
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
