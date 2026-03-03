const DataRedundancy = @import("data_redundancy.zig").DataRedundancy;
const BucketType = @import("bucket_type.zig").BucketType;

/// Specifies the information about the bucket that will be created. For more
/// information about
/// directory buckets, see [Directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html) in the
/// *Amazon S3 User Guide*.
///
/// This functionality is only supported by directory buckets.
pub const BucketInfo = struct {
    /// The number of Zone (Availability Zone or Local Zone) that's used for
    /// redundancy for the bucket.
    data_redundancy: ?DataRedundancy = null,

    /// The type of bucket.
    @"type": ?BucketType = null,
};
