/// The tags to apply to the AMI object that will be stored in the Amazon S3
/// bucket. For more
/// information, see [Categorizing your storage using
/// tags](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-tagging.html) in the *Amazon Simple Storage Service User Guide*.
pub const S3ObjectTag = struct {
    /// The key of the tag.
    ///
    /// Constraints: Tag keys are case-sensitive and can be up to 128 Unicode
    /// characters in
    /// length. May not begin with `aws`:.
    key: ?[]const u8,

    /// The value of the tag.
    ///
    /// Constraints: Tag values are case-sensitive and can be up to 256 Unicode
    /// characters in
    /// length.
    value: ?[]const u8,
};
