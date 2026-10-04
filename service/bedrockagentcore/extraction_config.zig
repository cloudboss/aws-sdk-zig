const aws = @import("aws");

/// The configuration for extraction behavior. Use this structure to specify
/// namespace variable keys and their values for namespace substitution during
/// long-term memory extraction.
pub const ExtractionConfig = struct {
    /// A map of `namespaceKeys` to their values. The service substitutes these
    /// values into `namespaceTemplates` during long-term memory extraction to
    /// control namespace hierarchy.
    namespace_variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .namespace_variables = "namespaceVariables",
    };
};
