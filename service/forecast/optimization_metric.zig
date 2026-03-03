const std = @import("std");

pub const OptimizationMetric = enum {
    wape,
    rmse,
    average_weighted_quantile_loss,
    mase,
    mape,

    pub const json_field_names = .{
        .wape = "WAPE",
        .rmse = "RMSE",
        .average_weighted_quantile_loss = "AverageWeightedQuantileLoss",
        .mase = "MASE",
        .mape = "MAPE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wape => "WAPE",
            .rmse => "RMSE",
            .average_weighted_quantile_loss => "AverageWeightedQuantileLoss",
            .mase => "MASE",
            .mape => "MAPE",
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
