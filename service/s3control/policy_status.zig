/// Indicates whether this access point policy is public. For more information
/// about how Amazon S3
/// evaluates policies to determine whether they are public, see [The Meaning of
/// "Public"](https://docs.aws.amazon.com/AmazonS3/latest/dev/access-control-block-public-access.html#access-control-block-public-access-policy-status) in the *Amazon S3 User Guide*.
pub const PolicyStatus = struct {
    is_public: bool = false,
};
