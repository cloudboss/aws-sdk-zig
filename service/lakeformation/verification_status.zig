const std = @import("std");

pub const VerificationStatus = enum {
    verified,
    verification_failed,
    not_verified,

    pub const json_field_names = .{
        .verified = "VERIFIED",
        .verification_failed = "VERIFICATION_FAILED",
        .not_verified = "NOT_VERIFIED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .verified => "VERIFIED",
            .verification_failed => "VERIFICATION_FAILED",
            .not_verified => "NOT_VERIFIED",
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
