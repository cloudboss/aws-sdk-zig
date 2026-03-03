/// Details about the response from the Lambda parsing of the output from the
/// post-processing step.
pub const PostProcessingParsedResponse = struct {
    /// The text returned by the parser.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
