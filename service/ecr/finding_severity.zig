const std = @import("std");

pub const FindingSeverity = enum {
    informational,
    low,
    medium,
    high,
    critical,
    @"undefined",

    pub const json_field_names = .{
        .informational = "INFORMATIONAL",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
        .@"undefined" = "UNDEFINED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .informational => "INFORMATIONAL",
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
            .critical => "CRITICAL",
            .@"undefined" => "UNDEFINED",
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
