const S3ClassificationScopeExclusionUpdate = @import("s3_classification_scope_exclusion_update.zig").S3ClassificationScopeExclusionUpdate;

/// Specifies changes to the list of S3 buckets that are excluded from automated
/// sensitive data discovery for an Amazon Macie account.
pub const S3ClassificationScopeUpdate = struct {
    /// The names of the S3 buckets to add or remove from the list.
    excludes: S3ClassificationScopeExclusionUpdate,

    pub const json_field_names = .{
        .excludes = "excludes",
    };
};
