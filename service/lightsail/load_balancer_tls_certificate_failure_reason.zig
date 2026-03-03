const std = @import("std");

pub const LoadBalancerTlsCertificateFailureReason = enum {
    no_available_contacts,
    additional_verification_required,
    domain_not_allowed,
    invalid_public_domain,
    other,

    pub const json_field_names = .{
        .no_available_contacts = "NO_AVAILABLE_CONTACTS",
        .additional_verification_required = "ADDITIONAL_VERIFICATION_REQUIRED",
        .domain_not_allowed = "DOMAIN_NOT_ALLOWED",
        .invalid_public_domain = "INVALID_PUBLIC_DOMAIN",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_available_contacts => "NO_AVAILABLE_CONTACTS",
            .additional_verification_required => "ADDITIONAL_VERIFICATION_REQUIRED",
            .domain_not_allowed => "DOMAIN_NOT_ALLOWED",
            .invalid_public_domain => "INVALID_PUBLIC_DOMAIN",
            .other => "OTHER",
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
