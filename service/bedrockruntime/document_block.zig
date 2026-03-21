const CitationsConfig = @import("citations_config.zig").CitationsConfig;
const DocumentFormat = @import("document_format.zig").DocumentFormat;
const DocumentSource = @import("document_source.zig").DocumentSource;

/// A document to include in a message.
pub const DocumentBlock = struct {
    /// Configuration settings that control how citations should be generated for
    /// this specific document.
    citations: ?CitationsConfig = null,

    /// Contextual information about how the document should be processed or
    /// interpreted by the model when generating citations.
    context: ?[]const u8 = null,

    /// The format of a document, or its extension.
    format: DocumentFormat = .txt,

    /// A name for the document. The name can only contain the following characters:
    ///
    /// * Alphanumeric characters
    /// * Whitespace characters (no more than one in a row)
    /// * Hyphens
    /// * Parentheses
    /// * Square brackets
    ///
    /// This field is vulnerable to prompt injections, because the model might
    /// inadvertently interpret it as instructions. Therefore, we recommend that you
    /// specify a neutral name.
    name: []const u8,

    /// Contains the content of the document.
    source: DocumentSource,

    pub const json_field_names = .{
        .citations = "citations",
        .context = "context",
        .format = "format",
        .name = "name",
        .source = "source",
    };
};
