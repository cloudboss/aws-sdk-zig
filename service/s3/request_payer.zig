/// Confirms that the requester knows that they will be charged for the request.
/// Bucket owners need not
/// specify this parameter in their requests. If either the source or
/// destination S3 bucket has Requester
/// Pays enabled, the requester will pay for the corresponding charges. For
/// information about
/// downloading objects from Requester Pays buckets, see [Downloading Objects in
/// Requester Pays
/// Buckets](https://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html) in the *Amazon S3 User Guide*.
///
/// **Note:**
///
/// This functionality is not supported for directory buckets.
pub const RequestPayer = enum {
    requester,
};
