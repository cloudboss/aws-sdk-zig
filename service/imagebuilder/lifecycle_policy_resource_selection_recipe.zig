/// Specifies an Image Builder recipe that the lifecycle policy uses for
/// resource selection.
pub const LifecyclePolicyResourceSelectionRecipe = struct {
    /// The name of an Image Builder recipe that the lifecycle policy uses for
    /// resource selection.
    name: []const u8,

    /// The version of the Image Builder recipe specified by the `name` field.
    semantic_version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .semantic_version = "semanticVersion",
    };
};
