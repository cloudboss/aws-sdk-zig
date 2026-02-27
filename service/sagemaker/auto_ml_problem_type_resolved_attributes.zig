const TabularResolvedAttributes = @import("tabular_resolved_attributes.zig").TabularResolvedAttributes;
const TextGenerationResolvedAttributes = @import("text_generation_resolved_attributes.zig").TextGenerationResolvedAttributes;

/// Stores resolved attributes specific to the problem type of an AutoML job V2.
pub const AutoMLProblemTypeResolvedAttributes = union(enum) {
    /// The resolved attributes for the tabular problem type.
    tabular_resolved_attributes: ?TabularResolvedAttributes,
    /// The resolved attributes for the text generation problem type.
    text_generation_resolved_attributes: ?TextGenerationResolvedAttributes,

    pub const json_field_names = .{
        .tabular_resolved_attributes = "TabularResolvedAttributes",
        .text_generation_resolved_attributes = "TextGenerationResolvedAttributes",
    };
};
