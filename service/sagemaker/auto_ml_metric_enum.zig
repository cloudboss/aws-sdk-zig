const std = @import("std");

pub const AutoMLMetricEnum = enum {
    accuracy,
    mse,
    f1,
    f1_macro,
    auc,
    rmse,
    balanced_accuracy,
    r2,
    recall,
    recall_macro,
    precision,
    precision_macro,
    mae,
    mape,
    mase,
    wape,
    average_weighted_quantile_loss,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .mse = "MSE",
        .f1 = "F1",
        .f1_macro = "F1macro",
        .auc = "AUC",
        .rmse = "RMSE",
        .balanced_accuracy = "BalancedAccuracy",
        .r2 = "R2",
        .recall = "Recall",
        .recall_macro = "RecallMacro",
        .precision = "Precision",
        .precision_macro = "PrecisionMacro",
        .mae = "MAE",
        .mape = "MAPE",
        .mase = "MASE",
        .wape = "WAPE",
        .average_weighted_quantile_loss = "AverageWeightedQuantileLoss",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accuracy => "Accuracy",
            .mse => "MSE",
            .f1 => "F1",
            .f1_macro => "F1macro",
            .auc => "AUC",
            .rmse => "RMSE",
            .balanced_accuracy => "BalancedAccuracy",
            .r2 => "R2",
            .recall => "Recall",
            .recall_macro => "RecallMacro",
            .precision => "Precision",
            .precision_macro => "PrecisionMacro",
            .mae => "MAE",
            .mape => "MAPE",
            .mase => "MASE",
            .wape => "WAPE",
            .average_weighted_quantile_loss => "AverageWeightedQuantileLoss",
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
