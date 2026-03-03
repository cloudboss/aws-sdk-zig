const std = @import("std");

pub const PolicyEvaluationDecisionType = enum {
    allowed,
    explicit_deny,
    implicit_deny,

    pub const json_field_names = .{
        .allowed = "allowed",
        .explicit_deny = "explicitDeny",
        .implicit_deny = "implicitDeny",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "allowed",
            .explicit_deny => "explicitDeny",
            .implicit_deny => "implicitDeny",
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
