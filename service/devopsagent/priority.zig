const std = @import("std");

/// Priority levels for tasks, from highest to lowest urgency
pub const Priority = enum {
    /// Highest priority
    critical,
    /// High priority
    high,
    /// Medium priority
    medium,
    /// Low priority
    low,
    /// Minimal priority
    minimal,

    pub const json_field_names = .{
        .critical = "CRITICAL",
        .high = "HIGH",
        .medium = "MEDIUM",
        .low = "LOW",
        .minimal = "MINIMAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .critical => "CRITICAL",
            .high => "HIGH",
            .medium => "MEDIUM",
            .low => "LOW",
            .minimal => "MINIMAL",
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
