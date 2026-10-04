/// A reference to a PEM-encoded private CA certificate stored as an Amazon S3
/// object.
pub const S3CertificateConfiguration = struct {
    /// The account ID of the Amazon S3 bucket owner. This ID is used for
    /// cross-account access to the bucket.
    bucket_owner_account_id: ?[]const u8 = null,

    /// The URI of the Amazon S3 object that contains the PEM-encoded certificate.
    uri: []const u8,

    pub const json_field_names = .{
        .bucket_owner_account_id = "bucketOwnerAccountId",
        .uri = "uri",
    };
};
