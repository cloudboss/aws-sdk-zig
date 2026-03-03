const std = @import("std");

pub const Metric = enum {
    blended_cost,
    unblended_cost,
    amortized_cost,
    net_unblended_cost,
    net_amortized_cost,
    usage_quantity,
    normalized_usage_amount,

    pub const json_field_names = .{
        .blended_cost = "BLENDED_COST",
        .unblended_cost = "UNBLENDED_COST",
        .amortized_cost = "AMORTIZED_COST",
        .net_unblended_cost = "NET_UNBLENDED_COST",
        .net_amortized_cost = "NET_AMORTIZED_COST",
        .usage_quantity = "USAGE_QUANTITY",
        .normalized_usage_amount = "NORMALIZED_USAGE_AMOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .blended_cost => "BLENDED_COST",
            .unblended_cost => "UNBLENDED_COST",
            .amortized_cost => "AMORTIZED_COST",
            .net_unblended_cost => "NET_UNBLENDED_COST",
            .net_amortized_cost => "NET_AMORTIZED_COST",
            .usage_quantity => "USAGE_QUANTITY",
            .normalized_usage_amount => "NORMALIZED_USAGE_AMOUNT",
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
