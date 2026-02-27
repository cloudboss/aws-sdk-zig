const MatchingBucket = @import("matching_bucket.zig").MatchingBucket;

/// Provides statistical data and other information about an Amazon Web Services
/// resource that Amazon Macie monitors and analyzes for your account.
pub const MatchingResource = struct {
    /// The details of an S3 bucket that Amazon Macie monitors and analyzes for your
    /// account.
    matching_bucket: ?MatchingBucket,

    pub const json_field_names = .{
        .matching_bucket = "matchingBucket",
    };
};
