const std = @import("std");

pub const InvalidCrossAccountRoleErrorCode = enum {
    role_does_not_exist_or_invalid_trust_relationship,
    role_does_not_have_correct_policy,

    pub const json_field_names = .{
        .role_does_not_exist_or_invalid_trust_relationship = "ROLE_DOES_NOT_EXIST_OR_INVALID_TRUST_RELATIONSHIP",
        .role_does_not_have_correct_policy = "ROLE_DOES_NOT_HAVE_CORRECT_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .role_does_not_exist_or_invalid_trust_relationship => "ROLE_DOES_NOT_EXIST_OR_INVALID_TRUST_RELATIONSHIP",
            .role_does_not_have_correct_policy => "ROLE_DOES_NOT_HAVE_CORRECT_POLICY",
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
