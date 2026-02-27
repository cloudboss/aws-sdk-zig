/// The code for an error or issue that prevented Amazon Macie from retrieving
/// and processing information about an S3 bucket and the bucket's objects.
pub const BucketMetadataErrorCode = enum {
    access_denied,
    bucket_count_exceeds_quota,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .bucket_count_exceeds_quota = "BUCKET_COUNT_EXCEEDS_QUOTA",
    };
};
