const ChunkingConfiguration = @import("chunking_configuration.zig").ChunkingConfiguration;
const ParsingConfiguration = @import("parsing_configuration.zig").ParsingConfiguration;

/// Contains details about how to ingest the documents in a data source.
pub const VectorIngestionConfiguration = struct {
    /// Details about how to chunk the documents in the data source. A chunk refers
    /// to an excerpt from a data source that is returned when the knowledge base
    /// that it belongs to is queried.
    chunking_configuration: ?ChunkingConfiguration = null,

    /// A custom parser for data source documents.
    parsing_configuration: ?ParsingConfiguration = null,

    pub const json_field_names = .{
        .chunking_configuration = "chunkingConfiguration",
        .parsing_configuration = "parsingConfiguration",
    };
};
