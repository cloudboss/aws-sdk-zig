/// Amazon S3 location of a JSONL file containing dataset examples.
pub const S3Source = struct {
    /// Amazon S3 URI of the JSONL file (for example,
    /// `s3://my-bucket/path/to/examples.jsonl`).
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
