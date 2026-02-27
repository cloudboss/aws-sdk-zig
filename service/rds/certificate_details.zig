/// The details of the DB instance’s server certificate.
///
/// For more information, see [Using SSL/TLS to encrypt a connection to a DB
/// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
pub const CertificateDetails = struct {
    /// The CA identifier of the CA certificate used for the DB instance's server
    /// certificate.
    ca_identifier: ?[]const u8,

    /// The expiration date of the DB instance’s server certificate.
    valid_till: ?i64,
};
