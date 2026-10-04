const Pillar = @import("pillar.zig").Pillar;

/// Item configuration for a specific Well-Architected Tool Framework pillar.
pub const PillarItem = struct {
    /// A list of item IDs to process for this pillar, such as best practice IDs,
    /// Amazon Web Services service names, or resource ARNs.
    ids: []const []const u8,

    /// The pillar this item configuration applies to.
    pillar: Pillar,

    pub const json_field_names = .{
        .ids = "ids",
        .pillar = "pillar",
    };
};
