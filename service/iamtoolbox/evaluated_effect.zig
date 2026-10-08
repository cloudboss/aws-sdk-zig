const std = @import("std");

/// The result of a policy evaluation.
pub const EvaluatedEffect = enum {
    allow,
    explicit_deny,
    implicit_deny,

    pub const json_field_names = .{
        .allow = "ALLOW",
        .explicit_deny = "EXPLICIT_DENY",
        .implicit_deny = "IMPLICIT_DENY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allow => "ALLOW",
            .explicit_deny => "EXPLICIT_DENY",
            .implicit_deny => "IMPLICIT_DENY",
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
