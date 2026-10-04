const AcmeAuthorizationBehavior = @import("acme_authorization_behavior.zig").AcmeAuthorizationBehavior;
const CertificateAuthority = @import("certificate_authority.zig").CertificateAuthority;
const Tag = @import("tag.zig").Tag;
const AcmeContact = @import("acme_contact.zig").AcmeContact;
const AcmeEndpointStatus = @import("acme_endpoint_status.zig").AcmeEndpointStatus;

/// Contains detailed information about an ACME endpoint.
pub const AcmeEndpoint = struct {
    /// The Amazon Resource Name (ARN) of the ACME endpoint.
    acme_endpoint_arn: ?[]const u8 = null,

    /// The authorization behavior of the ACME endpoint.
    authorization_behavior: ?AcmeAuthorizationBehavior = null,

    /// The certificate authority configuration for the ACME endpoint.
    certificate_authority: ?CertificateAuthority = null,

    /// Tags applied to certificates issued through this ACME endpoint.
    certificate_tags: ?[]const Tag = null,

    /// Whether ACME clients must provide contact information during account
    /// registration.
    contact: ?AcmeContact = null,

    /// The time at which the ACME endpoint was created.
    created_at: ?i64 = null,

    /// The URL of the ACME endpoint.
    endpoint_url: ?[]const u8 = null,

    /// The reason the ACME endpoint failed, if applicable.
    failure_reason: ?[]const u8 = null,

    /// The status of the ACME endpoint.
    status: ?AcmeEndpointStatus = null,

    /// The time at which the ACME endpoint was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .acme_endpoint_arn = "AcmeEndpointArn",
        .authorization_behavior = "AuthorizationBehavior",
        .certificate_authority = "CertificateAuthority",
        .certificate_tags = "CertificateTags",
        .contact = "Contact",
        .created_at = "CreatedAt",
        .endpoint_url = "EndpointUrl",
        .failure_reason = "FailureReason",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
