/// The input file to use for an outbound transformation.
pub const InputFileSource = union(enum) {
    /// Specify the input contents, as a string, for the source of an outbound
    /// transformation.
    file_content: ?[]const u8,

    pub const json_field_names = .{
        .file_content = "fileContent",
    };
};
