/// The bucket and key of an item stored in Amazon S3.
pub const S3Location = struct {
    /// The Amazon S3 bucket where the data is located.
    s3_bucket: ?[]const u8 = null,

    /// The Amazon S3 key where the data is located.
    s3_key: ?[]const u8 = null,
};
