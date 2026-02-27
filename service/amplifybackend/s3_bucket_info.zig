/// Describes the metadata of the S3 bucket.
pub const S3BucketInfo = struct {
    /// The creation date of the S3 bucket.
    creation_date: ?[]const u8,

    /// The name of the S3 bucket.
    name: ?[]const u8,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .name = "Name",
    };
};
