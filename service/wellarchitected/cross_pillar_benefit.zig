const ImpactCategory = @import("impact_category.zig").ImpactCategory;
const Pillar = @import("pillar.zig").Pillar;

/// A benefit on a different pillar from acting on the recommendation.
pub const CrossPillarBenefit = struct {
    /// A description of what changes and why it matters.
    description: []const u8,

    /// The severity of the benefit.
    impact: ImpactCategory,

    /// The pillar that would be positively impacted.
    pillar: Pillar,

    /// A short phrase describing the outcome.
    title: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .impact = "impact",
        .pillar = "pillar",
        .title = "title",
    };
};
