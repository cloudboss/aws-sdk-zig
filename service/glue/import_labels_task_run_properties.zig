/// Specifies configuration properties for an importing labels task run.
pub const ImportLabelsTaskRunProperties = struct {
    /// The Amazon Simple Storage Service (Amazon S3) path from where you will
    /// import the
    /// labels.
    input_s3_path: ?[]const u8 = null,

    /// Indicates whether to overwrite your existing labels.
    replace: bool = false,

    pub const json_field_names = .{
        .input_s3_path = "InputS3Path",
        .replace = "Replace",
    };
};
