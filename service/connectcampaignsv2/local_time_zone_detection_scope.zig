const std = @import("std");

/// Local TimeZone Detection scope.
pub const LocalTimeZoneDetectionScope = enum {
    primary_only,
    all_available,

    pub const json_field_names = .{
        .primary_only = "PRIMARY_ONLY",
        .all_available = "ALL_AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary_only => "PRIMARY_ONLY",
            .all_available => "ALL_AVAILABLE",
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
