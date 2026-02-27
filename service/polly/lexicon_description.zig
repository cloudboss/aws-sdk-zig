const LexiconAttributes = @import("lexicon_attributes.zig").LexiconAttributes;

/// Describes the content of the lexicon.
pub const LexiconDescription = struct {
    /// Provides lexicon metadata.
    attributes: ?LexiconAttributes,

    /// Name of the lexicon.
    name: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .name = "Name",
    };
};
