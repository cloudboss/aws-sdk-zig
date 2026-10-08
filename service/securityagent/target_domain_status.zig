const std = @import("std");

/// Verification status of a target domain.
pub const TargetDomainStatus = enum {
    /// Domain verification is pending.
    pending,
    /// Domain ownership has been verified.
    verified,
    /// Domain verification failed.
    failed,
    /// Domain is unreachable for verification.
    @"unreachable",

    pub const json_field_names = .{
        .pending = "PENDING",
        .verified = "VERIFIED",
        .failed = "FAILED",
        .@"unreachable" = "UNREACHABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .verified => "VERIFIED",
            .failed => "FAILED",
            .@"unreachable" => "UNREACHABLE",
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
