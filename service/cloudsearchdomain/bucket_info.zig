const Bucket = @import("bucket.zig").Bucket;

/// A container for the calculated facet values and counts.
pub const BucketInfo = struct {
    /// A list of the calculated facet values and counts.
    buckets: ?[]const Bucket,

    pub const json_field_names = .{
        .buckets = "buckets",
    };
};
