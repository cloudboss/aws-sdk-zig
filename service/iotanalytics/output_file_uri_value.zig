/// The value of the variable as a structure that specifies an output file URI.
pub const OutputFileUriValue = struct {
    /// The URI of the location where dataset contents are stored, usually the URI
    /// of a file in an
    /// S3 bucket.
    file_name: []const u8,

    pub const json_field_names = .{
        .file_name = "fileName",
    };
};
