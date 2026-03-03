const TextSegment = @import("text_segment.zig").TextSegment;

/// The documents used to generate an Amazon Q Business web experience response.
pub const SourceAttribution = struct {
    /// The number attached to a citation in an Amazon Q Business generated
    /// response.
    citation_number: ?i32 = null,

    /// The identifier of the data source from which the document was ingested. This
    /// field is not present if the document is ingested by directly calling the
    /// BatchPutDocument API (similar to checkDocumentAccess). If the document is
    /// from a file-upload data source, the datasource will be
    /// "uploaded-docs-file-stat-datasourceid".
    datasource_id: ?[]const u8 = null,

    /// The unique identifier of the source document used in the citation, obtained
    /// from the Amazon Q Business index during chat response generation. This ID is
    /// used as input to the `GetDocumentContent` API to retrieve the actual
    /// document content for user verification.
    document_id: ?[]const u8 = null,

    /// The identifier of the index containing the source document's metadata and
    /// access control information. This links the citation back to the specific
    /// Amazon Q Business index where the document's searchable content and
    /// permissions are stored.
    index_id: ?[]const u8 = null,

    /// The content extract from the document on which the generated response is
    /// based.
    snippet: ?[]const u8 = null,

    /// A text extract from a source document that is used for source attribution.
    text_message_segments: ?[]const TextSegment = null,

    /// The title of the document which is the source for the Amazon Q Business
    /// generated response.
    title: ?[]const u8 = null,

    /// The Unix timestamp when the Amazon Q Business application was last updated.
    updated_at: ?i64 = null,

    /// The URL of the document which is the source for the Amazon Q Business
    /// generated response.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .citation_number = "citationNumber",
        .datasource_id = "datasourceId",
        .document_id = "documentId",
        .index_id = "indexId",
        .snippet = "snippet",
        .text_message_segments = "textMessageSegments",
        .title = "title",
        .updated_at = "updatedAt",
        .url = "url",
    };
};
