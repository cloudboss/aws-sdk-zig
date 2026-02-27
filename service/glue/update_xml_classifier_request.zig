/// Specifies an XML classifier to be updated.
pub const UpdateXMLClassifierRequest = struct {
    /// An identifier of the data format that the classifier matches.
    classification: ?[]const u8,

    /// The name of the classifier.
    name: []const u8,

    /// The XML tag designating the element that contains each record in an XML
    /// document being
    /// parsed. This cannot identify a self-closing element (closed by `/>`). An
    /// empty
    /// row element that contains only attributes can be parsed as long as it ends
    /// with a closing tag
    /// (for example, `` is okay, but
    /// `` is not).
    row_tag: ?[]const u8,

    pub const json_field_names = .{
        .classification = "Classification",
        .name = "Name",
        .row_tag = "RowTag",
    };
};
