/// The location of an external Dataview in an S3 bucket.
pub const S3Location = struct {
    /// The name of the S3 bucket.
    bucket: []const u8,

    /// The path of the folder, within the S3 bucket that contains the Dataset.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
    };
};
