const RxNormTraitName = @import("rx_norm_trait_name.zig").RxNormTraitName;

/// The contextual information for the entity. InferRxNorm recognizes the trait
/// `NEGATION`, which is any indication that the patient is not taking a
/// medication.
pub const RxNormTrait = struct {
    /// Provides a name or contextual description about the trait.
    name: ?RxNormTraitName,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of the detected
    /// trait.
    score: ?f32,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
