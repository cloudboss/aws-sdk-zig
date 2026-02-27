/// The location of a result in Amazon Kendra.
pub const RetrievalResultKendraDocumentLocation = struct {
    /// The document's uri.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
