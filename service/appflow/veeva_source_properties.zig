/// The properties that are applied when using Veeva as a flow source.
pub const VeevaSourceProperties = struct {
    /// The document type specified in the Veeva document extract flow.
    document_type: ?[]const u8,

    /// Boolean value to include All Versions of files in Veeva document extract
    /// flow.
    include_all_versions: bool = false,

    /// Boolean value to include file renditions in Veeva document extract flow.
    include_renditions: bool = false,

    /// Boolean value to include source files in Veeva document extract flow.
    include_source_files: bool = false,

    /// The object specified in the Veeva flow source.
    object: []const u8,

    pub const json_field_names = .{
        .document_type = "documentType",
        .include_all_versions = "includeAllVersions",
        .include_renditions = "includeRenditions",
        .include_source_files = "includeSourceFiles",
        .object = "object",
    };
};
