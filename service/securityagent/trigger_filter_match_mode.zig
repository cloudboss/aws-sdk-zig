const std = @import("std");

/// Whether a filter's value must match its patterns.
pub const TriggerFilterMatchMode = enum {
    /// The filter passes when a value fully matches at least one pattern.
    include,
    /// The filter passes when no value fully matches any pattern.
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
