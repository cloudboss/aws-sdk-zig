const std = @import("std");

pub const ResourceType = enum {
    training_job,
    experiment,
    experiment_trial,
    experiment_trial_component,
    endpoint,
    model,
    model_package,
    model_package_group,
    pipeline,
    pipeline_execution,
    feature_group,
    feature_metadata,
    image,
    image_version,
    project,
    hyper_parameter_tuning_job,
    model_card,
    pipeline_version,

    pub const json_field_names = .{
        .training_job = "TrainingJob",
        .experiment = "Experiment",
        .experiment_trial = "ExperimentTrial",
        .experiment_trial_component = "ExperimentTrialComponent",
        .endpoint = "Endpoint",
        .model = "Model",
        .model_package = "ModelPackage",
        .model_package_group = "ModelPackageGroup",
        .pipeline = "Pipeline",
        .pipeline_execution = "PipelineExecution",
        .feature_group = "FeatureGroup",
        .feature_metadata = "FeatureMetadata",
        .image = "Image",
        .image_version = "ImageVersion",
        .project = "Project",
        .hyper_parameter_tuning_job = "HyperParameterTuningJob",
        .model_card = "ModelCard",
        .pipeline_version = "PipelineVersion",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .training_job => "TrainingJob",
            .experiment => "Experiment",
            .experiment_trial => "ExperimentTrial",
            .experiment_trial_component => "ExperimentTrialComponent",
            .endpoint => "Endpoint",
            .model => "Model",
            .model_package => "ModelPackage",
            .model_package_group => "ModelPackageGroup",
            .pipeline => "Pipeline",
            .pipeline_execution => "PipelineExecution",
            .feature_group => "FeatureGroup",
            .feature_metadata => "FeatureMetadata",
            .image => "Image",
            .image_version => "ImageVersion",
            .project => "Project",
            .hyper_parameter_tuning_job => "HyperParameterTuningJob",
            .model_card => "ModelCard",
            .pipeline_version => "PipelineVersion",
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
