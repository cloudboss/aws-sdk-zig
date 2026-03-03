const std = @import("std");

/// The email identity type. The identity type can be one of the following:
///
/// * `EMAIL_ADDRESS` – The identity is an email address.
///
/// * `DOMAIN` – The identity is a domain.
pub const IdentityType = enum {
    email_address,
    domain,
    managed_domain,

    pub const json_field_names = .{
        .email_address = "EMAIL_ADDRESS",
        .domain = "DOMAIN",
        .managed_domain = "MANAGED_DOMAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .email_address => "EMAIL_ADDRESS",
            .domain => "DOMAIN",
            .managed_domain => "MANAGED_DOMAIN",
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
