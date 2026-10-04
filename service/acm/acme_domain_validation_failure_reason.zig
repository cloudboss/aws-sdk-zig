const std = @import("std");

pub const AcmeDomainValidationFailureReason = enum {
    access_denied,
    domain_mismatch,
    domain_not_allowed,
    endpoint_not_active,
    hosted_zone_not_found,
    internal_failure,
    invalid_change_batch,
    invalid_public_domain,
    timed_out,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .domain_mismatch = "DOMAIN_MISMATCH",
        .domain_not_allowed = "DOMAIN_NOT_ALLOWED",
        .endpoint_not_active = "ENDPOINT_NOT_ACTIVE",
        .hosted_zone_not_found = "HOSTED_ZONE_NOT_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
        .invalid_change_batch = "INVALID_CHANGE_BATCH",
        .invalid_public_domain = "INVALID_PUBLIC_DOMAIN",
        .timed_out = "TIMED_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .domain_mismatch => "DOMAIN_MISMATCH",
            .domain_not_allowed => "DOMAIN_NOT_ALLOWED",
            .endpoint_not_active => "ENDPOINT_NOT_ACTIVE",
            .hosted_zone_not_found => "HOSTED_ZONE_NOT_FOUND",
            .internal_failure => "INTERNAL_FAILURE",
            .invalid_change_batch => "INVALID_CHANGE_BATCH",
            .invalid_public_domain => "INVALID_PUBLIC_DOMAIN",
            .timed_out => "TIMED_OUT",
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
