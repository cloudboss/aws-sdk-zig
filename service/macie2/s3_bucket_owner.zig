/// Provides information about the Amazon Web Services account that owns an S3
/// bucket.
pub const S3BucketOwner = struct {
    /// The display name of the account that owns the bucket.
    display_name: ?[]const u8 = null,

    /// The canonical user ID for the account that owns the bucket.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .id = "id",
    };
};
