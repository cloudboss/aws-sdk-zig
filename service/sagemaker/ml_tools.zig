const std = @import("std");

pub const MlTools = enum {
    data_wrangler,
    feature_store,
    emr_clusters,
    auto_ml,
    experiments,
    training,
    model_evaluation,
    pipelines,
    models,
    jump_start,
    inference_recommender,
    endpoints,
    projects,
    inference_optimization,
    performance_evaluation,
    lakera_guard,
    comet,
    deepchecks_llm_evaluation,
    fiddler,
    hyper_pod_clusters,
    running_instances,
    datasets,
    evaluators,

    pub const json_field_names = .{
        .data_wrangler = "DataWrangler",
        .feature_store = "FeatureStore",
        .emr_clusters = "EmrClusters",
        .auto_ml = "AutoMl",
        .experiments = "Experiments",
        .training = "Training",
        .model_evaluation = "ModelEvaluation",
        .pipelines = "Pipelines",
        .models = "Models",
        .jump_start = "JumpStart",
        .inference_recommender = "InferenceRecommender",
        .endpoints = "Endpoints",
        .projects = "Projects",
        .inference_optimization = "InferenceOptimization",
        .performance_evaluation = "PerformanceEvaluation",
        .lakera_guard = "LakeraGuard",
        .comet = "Comet",
        .deepchecks_llm_evaluation = "DeepchecksLLMEvaluation",
        .fiddler = "Fiddler",
        .hyper_pod_clusters = "HyperPodClusters",
        .running_instances = "RunningInstances",
        .datasets = "Datasets",
        .evaluators = "Evaluators",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_wrangler => "DataWrangler",
            .feature_store => "FeatureStore",
            .emr_clusters => "EmrClusters",
            .auto_ml => "AutoMl",
            .experiments => "Experiments",
            .training => "Training",
            .model_evaluation => "ModelEvaluation",
            .pipelines => "Pipelines",
            .models => "Models",
            .jump_start => "JumpStart",
            .inference_recommender => "InferenceRecommender",
            .endpoints => "Endpoints",
            .projects => "Projects",
            .inference_optimization => "InferenceOptimization",
            .performance_evaluation => "PerformanceEvaluation",
            .lakera_guard => "LakeraGuard",
            .comet => "Comet",
            .deepchecks_llm_evaluation => "DeepchecksLLMEvaluation",
            .fiddler => "Fiddler",
            .hyper_pod_clusters => "HyperPodClusters",
            .running_instances => "RunningInstances",
            .datasets => "Datasets",
            .evaluators => "Evaluators",
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
