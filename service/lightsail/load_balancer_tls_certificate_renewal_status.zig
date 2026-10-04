const std = @import("std");

pub const LoadBalancerTlsCertificateRenewalStatus = enum {
    pending_auto_renewal,
    pending_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_auto_renewal = "PENDING_AUTO_RENEWAL",
        .pending_validation = "PENDING_VALIDATION",
        .success = "SUCCESS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_auto_renewal => "PENDING_AUTO_RENEWAL",
            .pending_validation => "PENDING_VALIDATION",
            .success => "SUCCESS",
            .failed => "FAILED",
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
