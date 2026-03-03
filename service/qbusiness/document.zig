const AccessConfiguration = @import("access_configuration.zig").AccessConfiguration;
const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const DocumentContent = @import("document_content.zig").DocumentContent;
const ContentType = @import("content_type.zig").ContentType;
const DocumentEnrichmentConfiguration = @import("document_enrichment_configuration.zig").DocumentEnrichmentConfiguration;
const MediaExtractionConfiguration = @import("media_extraction_configuration.zig").MediaExtractionConfiguration;

/// A document in an Amazon Q Business application.
pub const Document = struct {
    /// Configuration information for access permission to a document.
    access_configuration: ?AccessConfiguration = null,

    /// Custom attributes to apply to the document for refining Amazon Q Business
    /// web experience responses.
    attributes: ?[]const DocumentAttribute = null,

    /// The contents of the document.
    content: ?DocumentContent = null,

    /// The file type of the document in the Blob field.
    ///
    /// If you want to index snippets or subsets of HTML documents instead of the
    /// entirety of the HTML documents, you add the `HTML` start and closing tags
    /// (`<HTML>content</HTML>`) around the content.
    content_type: ?ContentType = null,

    /// The configuration information for altering document metadata and content
    /// during the document ingestion process.
    document_enrichment_configuration: ?DocumentEnrichmentConfiguration = null,

    /// The identifier of the document.
    id: []const u8,

    /// The configuration for extracting information from media in the document.
    media_extraction_configuration: ?MediaExtractionConfiguration = null,

    /// The title of the document.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_configuration = "accessConfiguration",
        .attributes = "attributes",
        .content = "content",
        .content_type = "contentType",
        .document_enrichment_configuration = "documentEnrichmentConfiguration",
        .id = "id",
        .media_extraction_configuration = "mediaExtractionConfiguration",
        .title = "title",
    };
};
