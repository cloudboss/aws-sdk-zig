/// Specifies the class that categorizes the document being analyzed
pub const DocumentClass = struct {
    /// The name of the class.
    name: ?[]const u8,

    /// Page number in the input document. This field is present
    /// in the response only if your request includes the `Byte` parameter.
    page: ?i32,

    /// The confidence score that Amazon Comprehend has this class correctly
    /// attributed.
    score: ?f32,

    pub const json_field_names = .{
        .name = "Name",
        .page = "Page",
        .score = "Score",
    };
};
