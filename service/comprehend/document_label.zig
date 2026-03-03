/// Specifies one of the label or labels that categorize the document being
/// analyzed.
pub const DocumentLabel = struct {
    /// The name of the label.
    name: ?[]const u8 = null,

    /// Page number where the label occurs. This field is present
    /// in the response only if your request includes the `Byte` parameter.
    page: ?i32 = null,

    /// The confidence score that Amazon Comprehend has this label correctly
    /// attributed.
    score: ?f32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .page = "Page",
        .score = "Score",
    };
};
