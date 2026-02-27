const BucketLocationConstraint = @import("bucket_location_constraint.zig").BucketLocationConstraint;

/// The container for the bucket configuration.
///
/// This is not supported by Amazon S3 on Outposts buckets.
pub const CreateBucketConfiguration = struct {
    /// Specifies the Region where the bucket will be created. If you are creating a
    /// bucket on
    /// the US East (N. Virginia) Region (us-east-1), you do not need to specify the
    /// location.
    ///
    /// This is not supported by Amazon S3 on Outposts buckets.
    location_constraint: ?BucketLocationConstraint,
};
