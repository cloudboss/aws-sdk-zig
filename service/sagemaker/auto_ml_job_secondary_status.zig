const std = @import("std");

pub const AutoMLJobSecondaryStatus = enum {
    starting,
    max_candidates_reached,
    failed,
    stopped,
    max_auto_ml_job_runtime_reached,
    stopping,
    candidate_definitions_generated,
    completed,
    explainability_error,
    deploying_model,
    model_deployment_error,
    generating_model_insights_report,
    model_insights_error,
    analyzing_data,
    feature_engineering,
    model_tuning,
    generating_explainability_report,
    training_models,
    pre_training,

    pub const json_field_names = .{
        .starting = "Starting",
        .max_candidates_reached = "MaxCandidatesReached",
        .failed = "Failed",
        .stopped = "Stopped",
        .max_auto_ml_job_runtime_reached = "MaxAutoMLJobRuntimeReached",
        .stopping = "Stopping",
        .candidate_definitions_generated = "CandidateDefinitionsGenerated",
        .completed = "Completed",
        .explainability_error = "ExplainabilityError",
        .deploying_model = "DeployingModel",
        .model_deployment_error = "ModelDeploymentError",
        .generating_model_insights_report = "GeneratingModelInsightsReport",
        .model_insights_error = "ModelInsightsError",
        .analyzing_data = "AnalyzingData",
        .feature_engineering = "FeatureEngineering",
        .model_tuning = "ModelTuning",
        .generating_explainability_report = "GeneratingExplainabilityReport",
        .training_models = "TrainingModels",
        .pre_training = "PreTraining",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "Starting",
            .max_candidates_reached => "MaxCandidatesReached",
            .failed => "Failed",
            .stopped => "Stopped",
            .max_auto_ml_job_runtime_reached => "MaxAutoMLJobRuntimeReached",
            .stopping => "Stopping",
            .candidate_definitions_generated => "CandidateDefinitionsGenerated",
            .completed => "Completed",
            .explainability_error => "ExplainabilityError",
            .deploying_model => "DeployingModel",
            .model_deployment_error => "ModelDeploymentError",
            .generating_model_insights_report => "GeneratingModelInsightsReport",
            .model_insights_error => "ModelInsightsError",
            .analyzing_data => "AnalyzingData",
            .feature_engineering => "FeatureEngineering",
            .model_tuning => "ModelTuning",
            .generating_explainability_report => "GeneratingExplainabilityReport",
            .training_models => "TrainingModels",
            .pre_training => "PreTraining",
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
