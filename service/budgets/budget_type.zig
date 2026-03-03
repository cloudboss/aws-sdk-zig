const std = @import("std");

/// The type of a budget. It must be one of the following types:
///
/// `COST`, `USAGE`, `RI_UTILIZATION`,
/// `RI_COVERAGE`, `SAVINGS_PLANS_UTILIZATION`, or
/// `SAVINGS_PLANS_COVERAGE`.
pub const BudgetType = enum {
    usage,
    cost,
    ri_utilization,
    ri_coverage,
    sp_utilization,
    sp_coverage,

    pub const json_field_names = .{
        .usage = "USAGE",
        .cost = "COST",
        .ri_utilization = "RI_UTILIZATION",
        .ri_coverage = "RI_COVERAGE",
        .sp_utilization = "SAVINGS_PLANS_UTILIZATION",
        .sp_coverage = "SAVINGS_PLANS_COVERAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .usage => "USAGE",
            .cost => "COST",
            .ri_utilization => "RI_UTILIZATION",
            .ri_coverage => "RI_COVERAGE",
            .sp_utilization => "SAVINGS_PLANS_UTILIZATION",
            .sp_coverage => "SAVINGS_PLANS_COVERAGE",
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
