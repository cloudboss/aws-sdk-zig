const std = @import("std");

pub const ConfigRecommendationOptimizationType = enum {
    least_cost,
    least_change,
    best_az_recovery,
    least_errors,
    best_attainable,
    best_region_recovery,

    pub const json_field_names = .{
        .least_cost = "LeastCost",
        .least_change = "LeastChange",
        .best_az_recovery = "BestAZRecovery",
        .least_errors = "LeastErrors",
        .best_attainable = "BestAttainable",
        .best_region_recovery = "BestRegionRecovery",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .least_cost => "LeastCost",
            .least_change => "LeastChange",
            .best_az_recovery => "BestAZRecovery",
            .least_errors => "LeastErrors",
            .best_attainable => "BestAttainable",
            .best_region_recovery => "BestRegionRecovery",
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
