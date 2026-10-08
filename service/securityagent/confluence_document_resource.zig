/// A Confluence document (page) integrated as a resource.
pub const ConfluenceDocumentResource = struct {
    name: []const u8,

    /// The Confluence page identifier.
    page_id: []const u8,

    /// The Confluence space key containing the document.
    space_key: []const u8,

    /// The display title of the Confluence space.
    space_title: ?[]const u8 = null,

    /// The display title of the Confluence page.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .page_id = "pageId",
        .space_key = "spaceKey",
        .space_title = "spaceTitle",
        .title = "title",
    };
};
