const statusType = @import("status_type.zig").statusType;

/// Contains information about an X.509 signing certificate.
///
/// This data type is used as a response element in the
/// [UploadSigningCertificate](https://docs.aws.amazon.com/IAM/latest/APIReference/API_UploadSigningCertificate.html) and [ListSigningCertificates](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListSigningCertificates.html) operations.
pub const SigningCertificate = struct {
    /// The contents of the signing certificate.
    certificate_body: []const u8,

    /// The ID for the signing certificate.
    certificate_id: []const u8,

    /// The status of the signing certificate. `Active` means that the key is valid
    /// for API calls, while `Inactive` means it is not.
    status: statusType,

    /// The date when the signing certificate was uploaded.
    upload_date: ?i64 = null,

    /// The name of the user the signing certificate is associated with.
    user_name: []const u8,
};
