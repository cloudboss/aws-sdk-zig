const std = @import("std");

pub const AutoMLMetricExtendedEnum = enum {
    accuracy,
    mse,
    f1,
    f1_macro,
    auc,
    rmse,
    mae,
    r2,
    balanced_accuracy,
    precision,
    precision_macro,
    recall,
    recall_macro,
    log_loss,
    inference_latency,
    mape,
    mase,
    wape,
    average_weighted_quantile_loss,
    rouge1,
    rouge2,
    rougel,
    rougel_sum,
    perplexity,
    validation_loss,
    training_loss,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .mse = "MSE",
        .f1 = "F1",
        .f1_macro = "F1macro",
        .auc = "AUC",
        .rmse = "RMSE",
        .mae = "MAE",
        .r2 = "R2",
        .balanced_accuracy = "BalancedAccuracy",
        .precision = "Precision",
        .precision_macro = "PrecisionMacro",
        .recall = "Recall",
        .recall_macro = "RecallMacro",
        .log_loss = "LogLoss",
        .inference_latency = "InferenceLatency",
        .mape = "MAPE",
        .mase = "MASE",
        .wape = "WAPE",
        .average_weighted_quantile_loss = "AverageWeightedQuantileLoss",
        .rouge1 = "Rouge1",
        .rouge2 = "Rouge2",
        .rougel = "RougeL",
        .rougel_sum = "RougeLSum",
        .perplexity = "Perplexity",
        .validation_loss = "ValidationLoss",
        .training_loss = "TrainingLoss",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accuracy => "Accuracy",
            .mse => "MSE",
            .f1 => "F1",
            .f1_macro => "F1macro",
            .auc => "AUC",
            .rmse => "RMSE",
            .mae => "MAE",
            .r2 => "R2",
            .balanced_accuracy => "BalancedAccuracy",
            .precision => "Precision",
            .precision_macro => "PrecisionMacro",
            .recall => "Recall",
            .recall_macro => "RecallMacro",
            .log_loss => "LogLoss",
            .inference_latency => "InferenceLatency",
            .mape => "MAPE",
            .mase => "MASE",
            .wape => "WAPE",
            .average_weighted_quantile_loss => "AverageWeightedQuantileLoss",
            .rouge1 => "Rouge1",
            .rouge2 => "Rouge2",
            .rougel => "RougeL",
            .rougel_sum => "RougeLSum",
            .perplexity => "Perplexity",
            .validation_loss => "ValidationLoss",
            .training_loss => "TrainingLoss",
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
