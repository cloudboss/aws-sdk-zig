/// Describes the metadata of the S3 bucket.
pub const S3BucketInfo = struct {
    /// The creation date of the S3 bucket.
    creation_date: ?[]const u8 = null,

    /// The name of the S3 bucket.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .name = "Name",
    };
};
