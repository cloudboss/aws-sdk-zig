const aws = @import("aws");

const DefaultCategoryEffect = @import("default_category_effect.zig").DefaultCategoryEffect;

/// Contains the governance configuration for a custom permissions profile. When
/// governance controls are defined for a category, any capabilities in that
/// category not explicitly set to `ALLOW` in `Capabilities` are denied. Even
/// newly added capabilities in the category are implicitly disabled when Amazon
/// Quick releases them.
pub const Governance = struct {
    /// A map of `DefaultCategoryEffects`.
    default_category_effects: ?[]const aws.map.MapEntry(DefaultCategoryEffect) = null,

    pub const json_field_names = .{
        .default_category_effects = "DefaultCategoryEffects",
    };
};
