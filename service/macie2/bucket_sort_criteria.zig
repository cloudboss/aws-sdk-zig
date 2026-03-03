const OrderBy = @import("order_by.zig").OrderBy;

/// Specifies criteria for sorting the results of a query for information about
/// S3 buckets.
pub const BucketSortCriteria = struct {
    /// The name of the bucket property to sort the results by. This value can be
    /// one of the following properties that Amazon Macie defines as bucket
    /// metadata: accountId, bucketName, classifiableObjectCount,
    /// classifiableSizeInBytes, objectCount, sensitivityScore, or sizeInBytes.
    attribute_name: ?[]const u8 = null,

    /// The sort order to apply to the results, based on the value specified by the
    /// attributeName property. Valid values are: ASC, sort the results in ascending
    /// order; and, DESC, sort the results in descending order.
    order_by: ?OrderBy = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .order_by = "orderBy",
    };
};
