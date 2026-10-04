const std = @import("std");

pub const GrpcRetryPolicyEvent = enum {
    cancelled,
    deadline_exceeded,
    internal,
    resource_exhausted,
    unavailable,

    pub const json_field_names = .{
        .cancelled = "cancelled",
        .deadline_exceeded = "deadline-exceeded",
        .internal = "internal",
        .resource_exhausted = "resource-exhausted",
        .unavailable = "unavailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cancelled => "cancelled",
            .deadline_exceeded => "deadline-exceeded",
            .internal => "internal",
            .resource_exhausted => "resource-exhausted",
            .unavailable => "unavailable",
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
