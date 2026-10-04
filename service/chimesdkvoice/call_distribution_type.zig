const std = @import("std");

pub const CallDistributionType = enum {
    priority_weighted_distribution,
    load_balanced_distribution,

    pub const json_field_names = .{
        .priority_weighted_distribution = "PriorityWeightedDistribution",
        .load_balanced_distribution = "LoadBalancedDistribution",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .priority_weighted_distribution => "PriorityWeightedDistribution",
            .load_balanced_distribution => "LoadBalancedDistribution",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
