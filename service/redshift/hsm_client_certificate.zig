const Tag = @import("tag.zig").Tag;

/// Returns information about an HSM client certificate. The certificate is
/// stored in a
/// secure Hardware Storage Module (HSM), and used by the Amazon Redshift
/// cluster to encrypt data
/// files.
pub const HsmClientCertificate = struct {
    /// The identifier of the HSM client certificate.
    hsm_client_certificate_identifier: ?[]const u8 = null,

    /// The public key that the Amazon Redshift cluster will use to connect to the
    /// HSM. You must
    /// register the public key in the HSM.
    hsm_client_certificate_public_key: ?[]const u8 = null,

    /// The list of tags for the HSM client certificate.
    tags: ?[]const Tag = null,
};
