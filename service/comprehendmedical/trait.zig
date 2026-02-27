const AttributeName = @import("attribute_name.zig").AttributeName;

/// Provides contextual information about the extracted entity.
pub const Trait = struct {
    /// Provides a name or contextual description about the trait.
    name: ?AttributeName,

    /// The level of confidence that Amazon Comprehend Medical has in the accuracy
    /// of this trait.
    score: ?f32,

    pub const json_field_names = .{
        .name = "Name",
        .score = "Score",
    };
};
