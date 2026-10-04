const std = @import("std");

pub const Feature = enum {
    account,
    budgets,
    cost_anomaly_detection,
    cost_optimization_hub,
    free_tier,
    iam,
    payments,
    reservations,
    savings_plans,
    tax_settings,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .budgets = "BUDGETS",
        .cost_anomaly_detection = "COST_ANOMALY_DETECTION",
        .cost_optimization_hub = "COST_OPTIMIZATION_HUB",
        .free_tier = "FREE_TIER",
        .iam = "IAM",
        .payments = "PAYMENTS",
        .reservations = "RESERVATIONS",
        .savings_plans = "SAVINGS_PLANS",
        .tax_settings = "TAX_SETTINGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .budgets => "BUDGETS",
            .cost_anomaly_detection => "COST_ANOMALY_DETECTION",
            .cost_optimization_hub => "COST_OPTIMIZATION_HUB",
            .free_tier => "FREE_TIER",
            .iam => "IAM",
            .payments => "PAYMENTS",
            .reservations => "RESERVATIONS",
            .savings_plans => "SAVINGS_PLANS",
            .tax_settings => "TAX_SETTINGS",
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
