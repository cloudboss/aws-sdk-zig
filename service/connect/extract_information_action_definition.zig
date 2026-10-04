const RulesExtractionDefinitionIdentifier = @import("rules_extraction_definition_identifier.zig").RulesExtractionDefinitionIdentifier;

/// Information about the extract information action, which references
/// extraction definitions
/// to use when extracting structured data from customer interactions.
pub const ExtractInformationActionDefinition = struct {
    /// The list of extraction definition identifiers that specify what data to
    /// extract.
    rules_extraction_definitions: []const RulesExtractionDefinitionIdentifier,

    pub const json_field_names = .{
        .rules_extraction_definitions = "RulesExtractionDefinitions",
    };
};
