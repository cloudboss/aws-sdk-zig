const std = @import("std");

pub const NodeErrorCode = enum {
    validation,
    dependency_failed,
    bad_gateway,
    internal_server,

    pub const json_field_names = .{
        .validation = "VALIDATION",
        .dependency_failed = "DEPENDENCY_FAILED",
        .bad_gateway = "BAD_GATEWAY",
        .internal_server = "INTERNAL_SERVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .validation => "VALIDATION",
            .dependency_failed => "DEPENDENCY_FAILED",
            .bad_gateway => "BAD_GATEWAY",
            .internal_server => "INTERNAL_SERVER",
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
