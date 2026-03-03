/// Contains information about the pages of a document, defined by logical
/// boundary.
pub const SplitDocument = struct {
    /// The index for a given document in a DocumentGroup of a specific Type.
    index: ?i32 = null,

    /// An array of page numbers for a for a given document, ordered by logical
    /// boundary.
    pages: ?[]const i32 = null,

    pub const json_field_names = .{
        .index = "Index",
        .pages = "Pages",
    };
};
