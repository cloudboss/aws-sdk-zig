/// The destination where the assets in the revision will be exported.
pub const RevisionDestinationEntry = struct {
    /// The Amazon S3 bucket that is the destination for the assets in the revision.
    bucket: []const u8,

    /// A string representing the pattern for generated names of the individual
    /// assets in the revision. For more information about key patterns, see [Key
    /// patterns when exporting
    /// revisions](https://docs.aws.amazon.com/data-exchange/latest/userguide/jobs.html#revision-export-keypatterns).
    key_pattern: ?[]const u8 = null,

    /// The unique identifier for the revision.
    revision_id: []const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_pattern = "KeyPattern",
        .revision_id = "RevisionId",
    };
};
