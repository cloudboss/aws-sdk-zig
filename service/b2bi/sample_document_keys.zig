/// An array of the Amazon S3 keys used to identify the location for your sample
/// documents.
pub const SampleDocumentKeys = struct {
    /// An array of keys for your input sample documents.
    input: ?[]const u8,

    /// An array of keys for your output sample documents.
    output: ?[]const u8,

    pub const json_field_names = .{
        .input = "input",
        .output = "output",
    };
};
