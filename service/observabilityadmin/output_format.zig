const std = @import("std");

/// Enumeration of supported output formats for ELB access logs: PLAIN for
/// space-delimited format, JSON for structured JSON format.
pub const OutputFormat = enum {
    plain,
    json,

    pub const json_field_names = .{
        .plain = "plain",
        .json = "json",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plain => "plain",
            .json => "json",
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
