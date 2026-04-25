/// A revision destination is the Amazon S3 bucket folder destination to where
/// the export will be sent.
pub const AutoExportRevisionDestinationEntry = struct {
    /// The Amazon S3 bucket that is the destination for the event action.
    bucket: []const u8,

    /// A string representing the pattern for generated names of the individual
    /// assets in the revision. For more information about key patterns, see [Key
    /// patterns when exporting
    /// revisions](https://docs.aws.amazon.com/data-exchange/latest/userguide/jobs.html#revision-export-keypatterns).
    key_pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key_pattern = "KeyPattern",
    };
};
