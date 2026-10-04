const std = @import("std");

pub const ValidationFindingCode = enum {
    target_inaccessible,
    target_unusable,
    target_state_warning,
    aws_role_assumption_failed,
    web_identity_token_failed,
    outbound_web_identity_federation_disabled,
    provider_credential_creation_failed,
    tenant_summary,
    subscription_accessible,

    pub const json_field_names = .{
        .target_inaccessible = "TargetInaccessible",
        .target_unusable = "TargetUnusable",
        .target_state_warning = "TargetStateWarning",
        .aws_role_assumption_failed = "AwsRoleAssumptionFailed",
        .web_identity_token_failed = "WebIdentityTokenFailed",
        .outbound_web_identity_federation_disabled = "OutboundWebIdentityFederationDisabled",
        .provider_credential_creation_failed = "ProviderCredentialCreationFailed",
        .tenant_summary = "TenantSummary",
        .subscription_accessible = "SubscriptionAccessible",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .target_inaccessible => "TargetInaccessible",
            .target_unusable => "TargetUnusable",
            .target_state_warning => "TargetStateWarning",
            .aws_role_assumption_failed => "AwsRoleAssumptionFailed",
            .web_identity_token_failed => "WebIdentityTokenFailed",
            .outbound_web_identity_federation_disabled => "OutboundWebIdentityFederationDisabled",
            .provider_credential_creation_failed => "ProviderCredentialCreationFailed",
            .tenant_summary => "TenantSummary",
            .subscription_accessible => "SubscriptionAccessible",
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
