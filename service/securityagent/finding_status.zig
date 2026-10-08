const std = @import("std");

/// Finding status.
pub const FindingStatus = enum {
    active,
    resolved,
    accepted,
    false_positive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .resolved = "RESOLVED",
        .accepted = "ACCEPTED",
        .false_positive = "FALSE_POSITIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .resolved => "RESOLVED",
            .accepted => "ACCEPTED",
            .false_positive => "FALSE_POSITIVE",
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
