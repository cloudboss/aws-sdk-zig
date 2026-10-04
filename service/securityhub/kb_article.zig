/// A knowledge base article that provides additional guidance related to the
/// remediation target.
pub const KbArticle = struct {
    /// The title of the `KbArticle`.
    title: []const u8,

    /// The URL of the `KbArticle`.
    url: []const u8,

    pub const json_field_names = .{
        .title = "Title",
        .url = "Url",
    };
};
