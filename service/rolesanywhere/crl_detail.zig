/// The state of the certificate revocation list (CRL) after a read or write
/// operation.
pub const CrlDetail = struct {
    /// The ISO-8601 timestamp when the certificate revocation list (CRL) was
    /// created.
    created_at: ?i64,

    /// The ARN of the certificate revocation list (CRL).
    crl_arn: ?[]const u8,

    /// The state of the certificate revocation list (CRL) after a read or write
    /// operation.
    crl_data: ?[]const u8,

    /// The unique identifier of the certificate revocation list (CRL).
    crl_id: ?[]const u8,

    /// Indicates whether the certificate revocation list (CRL) is enabled.
    enabled: ?bool,

    /// The name of the certificate revocation list (CRL).
    name: ?[]const u8,

    /// The ARN of the TrustAnchor the certificate revocation list (CRL) will
    /// provide revocation for.
    trust_anchor_arn: ?[]const u8,

    /// The ISO-8601 timestamp when the certificate revocation list (CRL) was last
    /// updated.
    updated_at: ?i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .crl_arn = "crlArn",
        .crl_data = "crlData",
        .crl_id = "crlId",
        .enabled = "enabled",
        .name = "name",
        .trust_anchor_arn = "trustAnchorArn",
        .updated_at = "updatedAt",
    };
};
