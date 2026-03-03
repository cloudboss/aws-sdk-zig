const std = @import("std");

pub const AutoMLAlgorithm = enum {
    xgboost,
    linear_learner,
    mlp,
    lightgbm,
    catboost,
    randomforest,
    extra_trees,
    nn_torch,
    fastai,
    cnn_qr,
    deepar,
    prophet,
    npts,
    arima,
    ets,

    pub const json_field_names = .{
        .xgboost = "xgboost",
        .linear_learner = "linear-learner",
        .mlp = "mlp",
        .lightgbm = "lightgbm",
        .catboost = "catboost",
        .randomforest = "randomforest",
        .extra_trees = "extra-trees",
        .nn_torch = "nn-torch",
        .fastai = "fastai",
        .cnn_qr = "cnn-qr",
        .deepar = "deepar",
        .prophet = "prophet",
        .npts = "npts",
        .arima = "arima",
        .ets = "ets",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .xgboost => "xgboost",
            .linear_learner => "linear-learner",
            .mlp => "mlp",
            .lightgbm => "lightgbm",
            .catboost => "catboost",
            .randomforest => "randomforest",
            .extra_trees => "extra-trees",
            .nn_torch => "nn-torch",
            .fastai => "fastai",
            .cnn_qr => "cnn-qr",
            .deepar => "deepar",
            .prophet => "prophet",
            .npts => "npts",
            .arima => "arima",
            .ets => "ets",
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
