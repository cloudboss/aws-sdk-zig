const std = @import("std");

pub const RDSSavingsEstimationModeSource = enum {
    public_pricing,
    cost_explorer_rightsizing,
    cost_optimization_hub,

    pub const json_field_names = .{
        .public_pricing = "PublicPricing",
        .cost_explorer_rightsizing = "CostExplorerRightsizing",
        .cost_optimization_hub = "CostOptimizationHub",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_pricing => "PublicPricing",
            .cost_explorer_rightsizing => "CostExplorerRightsizing",
            .cost_optimization_hub => "CostOptimizationHub",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
