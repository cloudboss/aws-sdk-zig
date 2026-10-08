/// Source of the diff for a differential code scan.
pub const DiffSource = union(enum) {
    /// S3 URI pointing to a unified diff file. The file must be in standard unified
    /// diff format and stored in an S3 bucket connected to your Agent Space.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
