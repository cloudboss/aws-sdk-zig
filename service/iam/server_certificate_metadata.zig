/// Contains information about a server certificate without its certificate
/// body,
/// certificate chain, and private key.
///
/// This data type is used as a response element in the
/// [UploadServerCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UploadServerCertificate.html) and [ListServerCertificates](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListServerCertificates.html) operations.
pub const ServerCertificateMetadata = struct {
    /// The Amazon Resource Name (ARN) specifying the server certificate. For more
    /// information
    /// about ARNs and how to use them in policies, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    arn: []const u8,

    /// The date on which the certificate is set to expire.
    expiration: ?i64,

    /// The path to the server certificate. For more information about paths, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    path: []const u8,

    /// The stable and unique string identifying the server certificate. For more
    /// information
    /// about IDs, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    server_certificate_id: []const u8,

    /// The name that identifies the server certificate.
    server_certificate_name: []const u8,

    /// The date when the server certificate was uploaded.
    upload_date: ?i64,
};
