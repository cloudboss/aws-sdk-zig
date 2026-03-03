/// Returns the details of the DB instance’s server certificate.
///
/// For more information, see [Updating Your Amazon DocumentDB TLS
/// Certificates](https://docs.aws.amazon.com/documentdb/latest/developerguide/ca_cert_rotation.html) and
/// [
/// Encrypting Data in
/// Transit](https://docs.aws.amazon.com/documentdb/latest/developerguide/security.encryption.ssl.html) in the *Amazon DocumentDB Developer
/// Guide*.
pub const CertificateDetails = struct {
    /// The CA identifier of the CA certificate used for the DB instance's server
    /// certificate.
    ca_identifier: ?[]const u8 = null,

    /// The expiration date of the DB instance’s server certificate.
    valid_till: ?i64 = null,
};
