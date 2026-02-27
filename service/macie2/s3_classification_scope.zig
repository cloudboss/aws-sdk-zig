const S3ClassificationScopeExclusion = @import("s3_classification_scope_exclusion.zig").S3ClassificationScopeExclusion;

/// Specifies the S3 buckets that are excluded from automated sensitive data
/// discovery for an Amazon Macie account.
pub const S3ClassificationScope = struct {
    /// The S3 buckets that are excluded.
    excludes: S3ClassificationScopeExclusion,

    pub const json_field_names = .{
        .excludes = "excludes",
    };
};
