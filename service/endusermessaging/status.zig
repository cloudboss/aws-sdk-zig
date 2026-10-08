const std = @import("std");

/// Brand profile lifecycle status.
/// Exposed on brand profile API responses (Get, List, Create, Update).
pub const Status = enum {
    active,
    blocked,
    paused,
    cancelled,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .blocked = "BLOCKED",
        .paused = "PAUSED",
        .cancelled = "CANCELLED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .blocked => "BLOCKED",
            .paused => "PAUSED",
            .cancelled => "CANCELLED",
            .failed => "FAILED",
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
