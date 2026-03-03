const std = @import("std");

/// Custom output status enum
pub const CustomOutputStatus = enum {
    match,
    no_match,

    pub const json_field_names = .{
        .match = "MATCH",
        .no_match = "NO_MATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .match => "MATCH",
            .no_match => "NO_MATCH",
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
