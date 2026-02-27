const DefinitionLanguage = @import("definition_language.zig").DefinitionLanguage;

/// A document that defines an entity.
pub const DefinitionDocument = struct {
    /// The language used to define the entity. `GRAPHQL` is the only valid value.
    language: DefinitionLanguage,

    /// The GraphQL text that defines the entity.
    text: []const u8,

    pub const json_field_names = .{
        .language = "language",
        .text = "text",
    };
};
