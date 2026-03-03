const std = @import("std");

pub const CertificateStatus = enum {
    pending_validation,
    issued,
    inactive,
    expired,
    validation_timed_out,
    revoked,
    failed,

    pub const json_field_names = .{
        .pending_validation = "PENDING_VALIDATION",
        .issued = "ISSUED",
        .inactive = "INACTIVE",
        .expired = "EXPIRED",
        .validation_timed_out = "VALIDATION_TIMED_OUT",
        .revoked = "REVOKED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_validation => "PENDING_VALIDATION",
            .issued => "ISSUED",
            .inactive => "INACTIVE",
            .expired => "EXPIRED",
            .validation_timed_out => "VALIDATION_TIMED_OUT",
            .revoked => "REVOKED",
            .failed => "FAILED",
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
