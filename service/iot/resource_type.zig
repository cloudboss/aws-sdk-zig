const std = @import("std");

pub const ResourceType = enum {
    device_certificate,
    ca_certificate,
    iot_policy,
    cognito_identity_pool,
    client_id,
    account_settings,
    role_alias,
    iam_role,
    issuer_certificate,

    pub const json_field_names = .{
        .device_certificate = "DEVICE_CERTIFICATE",
        .ca_certificate = "CA_CERTIFICATE",
        .iot_policy = "IOT_POLICY",
        .cognito_identity_pool = "COGNITO_IDENTITY_POOL",
        .client_id = "CLIENT_ID",
        .account_settings = "ACCOUNT_SETTINGS",
        .role_alias = "ROLE_ALIAS",
        .iam_role = "IAM_ROLE",
        .issuer_certificate = "ISSUER_CERTIFICATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .device_certificate => "DEVICE_CERTIFICATE",
            .ca_certificate => "CA_CERTIFICATE",
            .iot_policy => "IOT_POLICY",
            .cognito_identity_pool => "COGNITO_IDENTITY_POOL",
            .client_id => "CLIENT_ID",
            .account_settings => "ACCOUNT_SETTINGS",
            .role_alias => "ROLE_ALIAS",
            .iam_role => "IAM_ROLE",
            .issuer_certificate => "ISSUER_CERTIFICATE",
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
