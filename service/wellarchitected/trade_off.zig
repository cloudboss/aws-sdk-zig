const Pillar = @import("pillar.zig").Pillar;
const RiskRating = @import("risk_rating.zig").RiskRating;

/// A negative trade-off from acting on the recommendation.
pub const TradeOff = struct {
    /// A description of the specific risk and the condition that triggers it.
    description: []const u8,

    /// A specific action to mitigate the trade-off and when to take it.
    mitigation: []const u8,

    /// The pillar that could be negatively impacted.
    pillar: Pillar,

    /// The risk rating for the trade-off.
    risk: RiskRating,

    /// An optional explanation providing additional context for the risk rating.
    risk_explanation: ?[]const u8 = null,

    /// A short phrase describing what is lost or degraded.
    title: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .mitigation = "mitigation",
        .pillar = "pillar",
        .risk = "risk",
        .risk_explanation = "riskExplanation",
        .title = "title",
    };
};
