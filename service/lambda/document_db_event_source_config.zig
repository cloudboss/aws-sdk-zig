const FullDocument = @import("full_document.zig").FullDocument;

/// Specific configuration settings for a DocumentDB event source.
pub const DocumentDBEventSourceConfig = struct {
    /// The name of the collection to consume within the database. If you do not
    /// specify a collection, Lambda consumes all collections.
    collection_name: ?[]const u8,

    /// The name of the database to consume within the DocumentDB cluster.
    database_name: ?[]const u8,

    /// Determines what DocumentDB sends to your event stream during document update
    /// operations. If set to UpdateLookup, DocumentDB sends a delta describing the
    /// changes, along with a copy of the entire document. Otherwise, DocumentDB
    /// sends only a partial document that contains the changes.
    full_document: ?FullDocument,
};
