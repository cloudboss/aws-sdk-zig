/// A classifier for `XML` content.
pub const XMLClassifier = struct {
    /// An identifier of the data format that the classifier matches.
    classification: []const u8,

    /// The time that this classifier was registered.
    creation_time: ?i64 = null,

    /// The time that this classifier was last updated.
    last_updated: ?i64 = null,

    /// The name of the classifier.
    name: []const u8,

    /// The XML tag designating the element that contains each record in an XML
    /// document being
    /// parsed. This can't identify a self-closing element (closed by `/>`). An
    /// empty
    /// row element that contains only attributes can be parsed as long as it ends
    /// with a closing tag
    /// (for example, `` is okay, but
    /// `` is not).
    row_tag: ?[]const u8 = null,

    /// The version of this classifier.
    version: i64 = 0,

    pub const json_field_names = .{
        .classification = "Classification",
        .creation_time = "CreationTime",
        .last_updated = "LastUpdated",
        .name = "Name",
        .row_tag = "RowTag",
        .version = "Version",
    };
};
