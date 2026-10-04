const std = @import("std");

/// Indicates whether the authorization policy for a Client VPN endpoint is
/// evaluated in shadow mode. Possible values include:
///
/// * `enabled` - The authorization policy is evaluated and the results are
///   logged, but access is not enforced.
///
/// * `disabled` - The authorization policy is enforced.
pub const ClientVpnAuthorizationPolicyShadowMode = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "enabled",
        .disabled = "disabled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enabled => "enabled",
            .disabled => "disabled",
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
