/// A LoRA adapter entry identified by an Amazon S3 URI.
pub const AIAdapterS3Entry = struct {
    /// A unique identifier for the adapter. This ID is used as the inference
    /// component name when the adapter is deployed. The ID must start and end with
    /// an alphanumeric character, can contain hyphens between alphanumeric
    /// characters, and can be up to 63 characters long.
    adapter_id: []const u8,

    /// The Amazon S3 URI of the directory that contains the LoRA adapter artifacts
    /// in PEFT format.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .s3_uri = "S3Uri",
    };
};
