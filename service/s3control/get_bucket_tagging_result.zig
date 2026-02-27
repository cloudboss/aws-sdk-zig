const S3Tag = @import("s3_tag.zig").S3Tag;

pub const GetBucketTaggingResult = struct {
    /// The tags set of the Outposts bucket.
    tag_set: []const S3Tag,
};
