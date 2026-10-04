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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
