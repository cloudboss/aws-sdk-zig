/// If present, indicates that the requester was successfully charged for the
/// request. For more
/// information, see [Using Requester Pays buckets for storage transfers and
/// usage](https://docs.aws.amazon.com/AmazonS3/latest/userguide/RequesterPaysBuckets.html) in the *Amazon Simple
/// Storage Service user guide*.
///
/// This functionality is not supported for directory buckets.
pub const RequestCharged = enum {
    requester,
};
