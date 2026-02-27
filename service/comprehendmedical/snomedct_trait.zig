const SNOMEDCTTraitName = @import("snomedct_trait_name.zig").SNOMEDCTTraitName;

/// Contextual information for an entity.
pub const SNOMEDCTTrait = struct {
    /// The name or contextual description of a detected trait.
    name: ?SNOMEDCTTraitName,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of a detected trait.
    score: ?f32,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
