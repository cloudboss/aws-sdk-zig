const std = @import("std");

pub const Metric = enum {
    blended_cost,
    unblended_cost,
    amortized_cost,
    net_unblended_cost,
    net_amortized_cost,
    usage_quantity,
    normalized_usage_amount,
    hours,

    pub const json_field_names = .{
        .blended_cost = "BlendedCost",
        .unblended_cost = "UnblendedCost",
        .amortized_cost = "AmortizedCost",
        .net_unblended_cost = "NetUnblendedCost",
        .net_amortized_cost = "NetAmortizedCost",
        .usage_quantity = "UsageQuantity",
        .normalized_usage_amount = "NormalizedUsageAmount",
        .hours = "Hours",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blended_cost => "BlendedCost",
            .unblended_cost => "UnblendedCost",
            .amortized_cost => "AmortizedCost",
            .net_unblended_cost => "NetUnblendedCost",
            .net_amortized_cost => "NetAmortizedCost",
            .usage_quantity => "UsageQuantity",
            .normalized_usage_amount => "NormalizedUsageAmount",
            .hours => "Hours",
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
