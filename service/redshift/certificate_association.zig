/// A cluster ID and custom domain name tied to a specific certificate. These
/// are typically
/// returned in a list.
pub const CertificateAssociation = struct {
    /// The cluster identifier for the certificate association.
    cluster_identifier: ?[]const u8,

    /// The custom domain name for the certificate association.
    custom_domain_name: ?[]const u8,
};
