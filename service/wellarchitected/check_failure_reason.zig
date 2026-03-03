const std = @import("std");

pub const CheckFailureReason = enum {
    assume_role_error,
    access_denied,
    unknown_error,
    premium_support_required,

    pub const json_field_names = .{
        .assume_role_error = "ASSUME_ROLE_ERROR",
        .access_denied = "ACCESS_DENIED",
        .unknown_error = "UNKNOWN_ERROR",
        .premium_support_required = "PREMIUM_SUPPORT_REQUIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .assume_role_error => "ASSUME_ROLE_ERROR",
            .access_denied => "ACCESS_DENIED",
            .unknown_error => "UNKNOWN_ERROR",
            .premium_support_required => "PREMIUM_SUPPORT_REQUIRED",
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
