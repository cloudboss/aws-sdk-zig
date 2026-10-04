const std = @import("std");

/// The readiness status.
pub const Readiness = enum {
    ready,
    not_ready,
    unknown,
    not_authorized,

    pub const json_field_names = .{
        .ready = "READY",
        .not_ready = "NOT_READY",
        .unknown = "UNKNOWN",
        .not_authorized = "NOT_AUTHORIZED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "READY",
            .not_ready => "NOT_READY",
            .unknown => "UNKNOWN",
            .not_authorized => "NOT_AUTHORIZED",
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
