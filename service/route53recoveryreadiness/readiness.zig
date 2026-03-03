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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
