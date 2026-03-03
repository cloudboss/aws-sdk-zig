const std = @import("std");

pub const Severity = enum {
    informational,
    low,
    medium,
    high,
    critical,

    pub const json_field_names = .{
        .informational = "INFORMATIONAL",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .critical = "CRITICAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .informational => "INFORMATIONAL",
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
            .critical => "CRITICAL",
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
