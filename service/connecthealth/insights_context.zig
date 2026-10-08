const InsightsType = @import("insights_type.zig").InsightsType;

/// Details for insights that user wants to generate
pub const InsightsContext = struct {
    insights_type: InsightsType,

    pub const json_field_names = .{
        .insights_type = "insightsType",
    };
};
