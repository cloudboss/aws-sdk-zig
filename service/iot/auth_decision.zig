const std = @import("std");

pub const AuthDecision = enum {
    allowed,
    explicit_deny,
    implicit_deny,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .explicit_deny = "EXPLICIT_DENY",
        .implicit_deny = "IMPLICIT_DENY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "ALLOWED",
            .explicit_deny => "EXPLICIT_DENY",
            .implicit_deny => "IMPLICIT_DENY",
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
