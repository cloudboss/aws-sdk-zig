const std = @import("std");

pub const FailureReason = enum {
    token_missing,
    token_expired,
    token_invalid,
    token_domain_mismatch,

    pub const json_field_names = .{
        .token_missing = "TOKEN_MISSING",
        .token_expired = "TOKEN_EXPIRED",
        .token_invalid = "TOKEN_INVALID",
        .token_domain_mismatch = "TOKEN_DOMAIN_MISMATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .token_missing => "TOKEN_MISSING",
            .token_expired => "TOKEN_EXPIRED",
            .token_invalid => "TOKEN_INVALID",
            .token_domain_mismatch => "TOKEN_DOMAIN_MISMATCH",
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
