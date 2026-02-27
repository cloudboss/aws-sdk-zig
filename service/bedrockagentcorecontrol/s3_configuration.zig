/// The Amazon S3 configuration for a gateway. This structure defines how the
/// gateway accesses files in Amazon S3.
pub const S3Configuration = struct {
    /// The account ID of the Amazon S3 bucket owner. This ID is used for
    /// cross-account access to the bucket.
    bucket_owner_account_id: ?[]const u8,

    /// The URI of the Amazon S3 object. This URI specifies the location of the
    /// object in Amazon S3.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .bucket_owner_account_id = "bucketOwnerAccountId",
        .uri = "uri",
    };
};
