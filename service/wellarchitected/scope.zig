const PillarItem = @import("pillar_item.zig").PillarItem;
const Pillar = @import("pillar.zig").Pillar;

/// Defines the scope for recommendation generation, specifying which pillars
/// and goals to focus on.
pub const Scope = struct {
    /// Specific goal IDs to focus on during recommendation generation.
    goal_ids: ?[]const []const u8 = null,

    /// Optional per-pillar item filtering configuration.
    items: ?[]const PillarItem = null,

    /// The Well-Architected Tool Framework pillars to include in the generation
    /// scope.
    pillars: []const Pillar,

    pub const json_field_names = .{
        .goal_ids = "goalIds",
        .items = "items",
        .pillars = "pillars",
    };
};
