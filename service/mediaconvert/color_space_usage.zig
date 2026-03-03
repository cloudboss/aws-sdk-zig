const std = @import("std");

/// There are two sources for color metadata, the input file and the job input
/// settings Color space and HDR master display information settings. The Color
/// space usage setting determines which takes precedence. Choose Force to use
/// color metadata from the input job settings. If you don't specify values for
/// those settings, the service defaults to using metadata from your input.
/// FALLBACK - Choose Fallback to use color metadata from the source when it is
/// present. If there's no color metadata in your input file, the service
/// defaults to using values you specify in the input settings.
pub const ColorSpaceUsage = enum {
    force,
    fallback,

    pub const json_field_names = .{
        .force = "FORCE",
        .fallback = "FALLBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .force => "FORCE",
            .fallback => "FALLBACK",
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
