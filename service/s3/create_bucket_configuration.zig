const BucketInfo = @import("bucket_info.zig").BucketInfo;
const LocationInfo = @import("location_info.zig").LocationInfo;
const BucketLocationConstraint = @import("bucket_location_constraint.zig").BucketLocationConstraint;
const Tag = @import("tag.zig").Tag;

/// The configuration information for the bucket.
pub const CreateBucketConfiguration = struct {
    /// Specifies the information about the bucket that will be created.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported by directory buckets.
    bucket: ?BucketInfo,

    /// Specifies the location where the bucket will be created.
    ///
    /// **Directory buckets ** - The location type is Availability Zone or Local
    /// Zone. To
    /// use the Local Zone location type, your account must be enabled
    /// for Local Zones. Otherwise, you get an HTTP `403 Forbidden` error with the
    /// error code
    /// `AccessDenied`. To learn more,
    /// see [Enable
    /// accounts for Local
    /// Zones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/opt-in-directory-bucket-lz.html) in the *Amazon S3 User Guide*.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported by directory buckets.
    location: ?LocationInfo,

    /// Specifies the Region where the bucket will be created. You might choose a
    /// Region to optimize
    /// latency, minimize costs, or address regulatory requirements. For example, if
    /// you reside in Europe, you
    /// will probably find it advantageous to create buckets in the Europe (Ireland)
    /// Region.
    ///
    /// If you don't specify a Region, the bucket is created in the US East (N.
    /// Virginia) Region (us-east-1)
    /// by default. Configurations using the value `EU` will create a bucket in
    /// `eu-west-1`.
    ///
    /// For a list of the valid values for all of the Amazon Web Services Regions,
    /// see [Regions and
    /// Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region).
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    location_constraint: ?BucketLocationConstraint,

    /// An array of tags that you can apply to the bucket that you're creating. Tags
    /// are key-value pairs of metadata used to categorize and organize your
    /// buckets, track costs, and control access.
    ///
    /// You must have the `s3:TagResource` permission to create a general
    /// purpose bucket with tags or the `s3express:TagResource` permission to create
    /// a directory bucket with tags.
    ///
    /// When creating buckets with tags, note that tag-based conditions using
    /// `aws:ResourceTag` and `s3:BucketTag` condition keys are applicable only
    /// after ABAC is enabled on the bucket. To learn more, see [Enabling ABAC in
    /// general purpose
    /// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/buckets-tagging-enable-abac.html).
    tags: ?[]const Tag,
};
