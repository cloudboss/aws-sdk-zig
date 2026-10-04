const std = @import("std");

/// The status of a certificate update. Possible values:
///
/// * `PENDING_DOMAIN_VALIDATION` – The update is waiting for domain validation
///   to complete.
/// * `SUCCESS` – The update completed successfully.
/// * `FAILED` – The update failed.
pub const UpdateStatus = enum {
    pending_domain_validation,
    success,
    failed,

    pub const json_field_names = .{
        .pending_domain_validation = "PENDING_DOMAIN_VALIDATION",
        .success = "SUCCESS",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_domain_validation => "PENDING_DOMAIN_VALIDATION",
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
