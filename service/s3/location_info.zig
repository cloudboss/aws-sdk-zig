const LocationType = @import("location_type.zig").LocationType;

/// Specifies the location where the bucket will be created.
///
/// For directory buckets, the location type is Availability Zone or Local Zone.
/// For more information about
/// directory buckets, see [Working with
/// directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html) in the *Amazon S3 User Guide*.
///
/// This functionality is only supported by directory buckets.
pub const LocationInfo = struct {
    /// The name of the location where the bucket will be created.
    ///
    /// For directory buckets, the name of the location is the Zone ID of the
    /// Availability Zone (AZ) or Local Zone (LZ) where
    /// the bucket will be created. An example AZ ID value is `usw2-az1`.
    name: ?[]const u8 = null,

    /// The type of location where the bucket will be created.
    @"type": ?LocationType = null,
};
