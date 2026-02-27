const IssuerCertificateIdentifier = @import("issuer_certificate_identifier.zig").IssuerCertificateIdentifier;
const PolicyVersionIdentifier = @import("policy_version_identifier.zig").PolicyVersionIdentifier;

/// Information that identifies the noncompliant resource.
pub const ResourceIdentifier = struct {
    /// The account with which the resource is associated.
    account: ?[]const u8,

    /// The ID of the CA certificate used to authorize the certificate.
    ca_certificate_id: ?[]const u8,

    /// The client ID.
    client_id: ?[]const u8,

    /// The ID of the Amazon Cognito identity pool.
    cognito_identity_pool_id: ?[]const u8,

    /// The ARN of the identified device certificate.
    device_certificate_arn: ?[]const u8,

    /// The ID of the certificate attached to the resource.
    device_certificate_id: ?[]const u8,

    /// The ARN of the IAM role that has overly permissive actions.
    iam_role_arn: ?[]const u8,

    /// The issuer certificate identifier.
    issuer_certificate_identifier: ?IssuerCertificateIdentifier,

    /// The version of the policy associated with the resource.
    policy_version_identifier: ?PolicyVersionIdentifier,

    /// The ARN of the role alias that has overly permissive actions.
    role_alias_arn: ?[]const u8,

    pub const json_field_names = .{
        .account = "account",
        .ca_certificate_id = "caCertificateId",
        .client_id = "clientId",
        .cognito_identity_pool_id = "cognitoIdentityPoolId",
        .device_certificate_arn = "deviceCertificateArn",
        .device_certificate_id = "deviceCertificateId",
        .iam_role_arn = "iamRoleArn",
        .issuer_certificate_identifier = "issuerCertificateIdentifier",
        .policy_version_identifier = "policyVersionIdentifier",
        .role_alias_arn = "roleAliasArn",
    };
};
