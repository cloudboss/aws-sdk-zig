const aws = @import("aws");
const std = @import("std");

const cancel_trained_model = @import("cancel_trained_model.zig");
const cancel_trained_model_inference_job = @import("cancel_trained_model_inference_job.zig");
const create_audience_model = @import("create_audience_model.zig");
const create_configured_audience_model = @import("create_configured_audience_model.zig");
const create_configured_model_algorithm = @import("create_configured_model_algorithm.zig");
const create_configured_model_algorithm_association = @import("create_configured_model_algorithm_association.zig");
const create_ml_input_channel = @import("create_ml_input_channel.zig");
const create_trained_model = @import("create_trained_model.zig");
const create_training_dataset = @import("create_training_dataset.zig");
const delete_audience_generation_job = @import("delete_audience_generation_job.zig");
const delete_audience_model = @import("delete_audience_model.zig");
const delete_configured_audience_model = @import("delete_configured_audience_model.zig");
const delete_configured_audience_model_policy = @import("delete_configured_audience_model_policy.zig");
const delete_configured_model_algorithm = @import("delete_configured_model_algorithm.zig");
const delete_configured_model_algorithm_association = @import("delete_configured_model_algorithm_association.zig");
const delete_ml_configuration = @import("delete_ml_configuration.zig");
const delete_ml_input_channel_data = @import("delete_ml_input_channel_data.zig");
const delete_trained_model_output = @import("delete_trained_model_output.zig");
const delete_training_dataset = @import("delete_training_dataset.zig");
const get_audience_generation_job = @import("get_audience_generation_job.zig");
const get_audience_model = @import("get_audience_model.zig");
const get_collaboration_configured_model_algorithm_association = @import("get_collaboration_configured_model_algorithm_association.zig");
const get_collaboration_ml_input_channel = @import("get_collaboration_ml_input_channel.zig");
const get_collaboration_trained_model = @import("get_collaboration_trained_model.zig");
const get_configured_audience_model = @import("get_configured_audience_model.zig");
const get_configured_audience_model_policy = @import("get_configured_audience_model_policy.zig");
const get_configured_model_algorithm = @import("get_configured_model_algorithm.zig");
const get_configured_model_algorithm_association = @import("get_configured_model_algorithm_association.zig");
const get_ml_configuration = @import("get_ml_configuration.zig");
const get_ml_input_channel = @import("get_ml_input_channel.zig");
const get_trained_model = @import("get_trained_model.zig");
const get_trained_model_inference_job = @import("get_trained_model_inference_job.zig");
const get_training_dataset = @import("get_training_dataset.zig");
const list_audience_export_jobs = @import("list_audience_export_jobs.zig");
const list_audience_generation_jobs = @import("list_audience_generation_jobs.zig");
const list_audience_models = @import("list_audience_models.zig");
const list_collaboration_configured_model_algorithm_associations = @import("list_collaboration_configured_model_algorithm_associations.zig");
const list_collaboration_ml_input_channels = @import("list_collaboration_ml_input_channels.zig");
const list_collaboration_trained_model_export_jobs = @import("list_collaboration_trained_model_export_jobs.zig");
const list_collaboration_trained_model_inference_jobs = @import("list_collaboration_trained_model_inference_jobs.zig");
const list_collaboration_trained_models = @import("list_collaboration_trained_models.zig");
const list_configured_audience_models = @import("list_configured_audience_models.zig");
const list_configured_model_algorithm_associations = @import("list_configured_model_algorithm_associations.zig");
const list_configured_model_algorithms = @import("list_configured_model_algorithms.zig");
const list_ml_input_channels = @import("list_ml_input_channels.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_trained_model_inference_jobs = @import("list_trained_model_inference_jobs.zig");
const list_trained_model_versions = @import("list_trained_model_versions.zig");
const list_trained_models = @import("list_trained_models.zig");
const list_training_datasets = @import("list_training_datasets.zig");
const put_configured_audience_model_policy = @import("put_configured_audience_model_policy.zig");
const put_ml_configuration = @import("put_ml_configuration.zig");
const start_audience_export_job = @import("start_audience_export_job.zig");
const start_audience_generation_job = @import("start_audience_generation_job.zig");
const start_trained_model_export_job = @import("start_trained_model_export_job.zig");
const start_trained_model_inference_job = @import("start_trained_model_inference_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_configured_audience_model = @import("update_configured_audience_model.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CleanRoomsML";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Submits a request to cancel the trained model job.
    pub fn cancelTrainedModel(self: *Self, allocator: std.mem.Allocator, input: cancel_trained_model.CancelTrainedModelInput, options: CallOptions) !cancel_trained_model.CancelTrainedModelOutput {
        return cancel_trained_model.execute(self, allocator, input, options);
    }

    /// Submits a request to cancel a trained model inference job.
    pub fn cancelTrainedModelInferenceJob(self: *Self, allocator: std.mem.Allocator, input: cancel_trained_model_inference_job.CancelTrainedModelInferenceJobInput, options: CallOptions) !cancel_trained_model_inference_job.CancelTrainedModelInferenceJobOutput {
        return cancel_trained_model_inference_job.execute(self, allocator, input, options);
    }

    /// Defines the information necessary to create an audience model. An audience
    /// model is a machine learning model that Clean Rooms ML trains to measure
    /// similarity between users. Clean Rooms ML manages training and storing the
    /// audience model. The audience model can be used in multiple calls to the
    /// StartAudienceGenerationJob API.
    pub fn createAudienceModel(self: *Self, allocator: std.mem.Allocator, input: create_audience_model.CreateAudienceModelInput, options: CallOptions) !create_audience_model.CreateAudienceModelOutput {
        return create_audience_model.execute(self, allocator, input, options);
    }

    /// Defines the information necessary to create a configured audience model.
    pub fn createConfiguredAudienceModel(self: *Self, allocator: std.mem.Allocator, input: create_configured_audience_model.CreateConfiguredAudienceModelInput, options: CallOptions) !create_configured_audience_model.CreateConfiguredAudienceModelOutput {
        return create_configured_audience_model.execute(self, allocator, input, options);
    }

    /// Creates a configured model algorithm using a container image stored in an
    /// ECR repository.
    pub fn createConfiguredModelAlgorithm(self: *Self, allocator: std.mem.Allocator, input: create_configured_model_algorithm.CreateConfiguredModelAlgorithmInput, options: CallOptions) !create_configured_model_algorithm.CreateConfiguredModelAlgorithmOutput {
        return create_configured_model_algorithm.execute(self, allocator, input, options);
    }

    /// Associates a configured model algorithm to a collaboration for use by any
    /// member of the collaboration.
    pub fn createConfiguredModelAlgorithmAssociation(self: *Self, allocator: std.mem.Allocator, input: create_configured_model_algorithm_association.CreateConfiguredModelAlgorithmAssociationInput, options: CallOptions) !create_configured_model_algorithm_association.CreateConfiguredModelAlgorithmAssociationOutput {
        return create_configured_model_algorithm_association.execute(self, allocator, input, options);
    }

    /// Provides the information to create an ML input channel. An ML input channel
    /// is the result of a query that can be used for ML modeling.
    pub fn createMlInputChannel(self: *Self, allocator: std.mem.Allocator, input: create_ml_input_channel.CreateMLInputChannelInput, options: CallOptions) !create_ml_input_channel.CreateMLInputChannelOutput {
        return create_ml_input_channel.execute(self, allocator, input, options);
    }

    /// Creates a trained model from an associated configured model algorithm using
    /// data from any member of the collaboration.
    pub fn createTrainedModel(self: *Self, allocator: std.mem.Allocator, input: create_trained_model.CreateTrainedModelInput, options: CallOptions) !create_trained_model.CreateTrainedModelOutput {
        return create_trained_model.execute(self, allocator, input, options);
    }

    /// Defines the information necessary to create a training dataset. In Clean
    /// Rooms ML, the `TrainingDataset` is metadata that points to a Glue table,
    /// which is read only during `AudienceModel` creation.
    pub fn createTrainingDataset(self: *Self, allocator: std.mem.Allocator, input: create_training_dataset.CreateTrainingDatasetInput, options: CallOptions) !create_training_dataset.CreateTrainingDatasetOutput {
        return create_training_dataset.execute(self, allocator, input, options);
    }

    /// Deletes the specified audience generation job, and removes all data
    /// associated with the job.
    pub fn deleteAudienceGenerationJob(self: *Self, allocator: std.mem.Allocator, input: delete_audience_generation_job.DeleteAudienceGenerationJobInput, options: CallOptions) !delete_audience_generation_job.DeleteAudienceGenerationJobOutput {
        return delete_audience_generation_job.execute(self, allocator, input, options);
    }

    /// Specifies an audience model that you want to delete. You can't delete an
    /// audience model if there are any configured audience models that depend on
    /// the audience model.
    pub fn deleteAudienceModel(self: *Self, allocator: std.mem.Allocator, input: delete_audience_model.DeleteAudienceModelInput, options: CallOptions) !delete_audience_model.DeleteAudienceModelOutput {
        return delete_audience_model.execute(self, allocator, input, options);
    }

    /// Deletes the specified configured audience model. You can't delete a
    /// configured audience model if there are any lookalike models that use the
    /// configured audience model. If you delete a configured audience model, it
    /// will be removed from any collaborations that it is associated to.
    pub fn deleteConfiguredAudienceModel(self: *Self, allocator: std.mem.Allocator, input: delete_configured_audience_model.DeleteConfiguredAudienceModelInput, options: CallOptions) !delete_configured_audience_model.DeleteConfiguredAudienceModelOutput {
        return delete_configured_audience_model.execute(self, allocator, input, options);
    }

    /// Deletes the specified configured audience model policy.
    pub fn deleteConfiguredAudienceModelPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_configured_audience_model_policy.DeleteConfiguredAudienceModelPolicyInput, options: CallOptions) !delete_configured_audience_model_policy.DeleteConfiguredAudienceModelPolicyOutput {
        return delete_configured_audience_model_policy.execute(self, allocator, input, options);
    }

    /// Deletes a configured model algorithm.
    pub fn deleteConfiguredModelAlgorithm(self: *Self, allocator: std.mem.Allocator, input: delete_configured_model_algorithm.DeleteConfiguredModelAlgorithmInput, options: CallOptions) !delete_configured_model_algorithm.DeleteConfiguredModelAlgorithmOutput {
        return delete_configured_model_algorithm.execute(self, allocator, input, options);
    }

    /// Deletes a configured model algorithm association.
    pub fn deleteConfiguredModelAlgorithmAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_configured_model_algorithm_association.DeleteConfiguredModelAlgorithmAssociationInput, options: CallOptions) !delete_configured_model_algorithm_association.DeleteConfiguredModelAlgorithmAssociationOutput {
        return delete_configured_model_algorithm_association.execute(self, allocator, input, options);
    }

    /// Deletes a ML modeling configuration.
    pub fn deleteMlConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_ml_configuration.DeleteMLConfigurationInput, options: CallOptions) !delete_ml_configuration.DeleteMLConfigurationOutput {
        return delete_ml_configuration.execute(self, allocator, input, options);
    }

    /// Provides the information necessary to delete an ML input channel.
    pub fn deleteMlInputChannelData(self: *Self, allocator: std.mem.Allocator, input: delete_ml_input_channel_data.DeleteMLInputChannelDataInput, options: CallOptions) !delete_ml_input_channel_data.DeleteMLInputChannelDataOutput {
        return delete_ml_input_channel_data.execute(self, allocator, input, options);
    }

    /// Deletes the model artifacts stored by the service.
    pub fn deleteTrainedModelOutput(self: *Self, allocator: std.mem.Allocator, input: delete_trained_model_output.DeleteTrainedModelOutputInput, options: CallOptions) !delete_trained_model_output.DeleteTrainedModelOutputOutput {
        return delete_trained_model_output.execute(self, allocator, input, options);
    }

    /// Specifies a training dataset that you want to delete. You can't delete a
    /// training dataset if there are any audience models that depend on the
    /// training dataset. In Clean Rooms ML, the `TrainingDataset` is metadata that
    /// points to a Glue table, which is read only during `AudienceModel` creation.
    /// This action deletes the metadata.
    pub fn deleteTrainingDataset(self: *Self, allocator: std.mem.Allocator, input: delete_training_dataset.DeleteTrainingDatasetInput, options: CallOptions) !delete_training_dataset.DeleteTrainingDatasetOutput {
        return delete_training_dataset.execute(self, allocator, input, options);
    }

    /// Returns information about an audience generation job.
    pub fn getAudienceGenerationJob(self: *Self, allocator: std.mem.Allocator, input: get_audience_generation_job.GetAudienceGenerationJobInput, options: CallOptions) !get_audience_generation_job.GetAudienceGenerationJobOutput {
        return get_audience_generation_job.execute(self, allocator, input, options);
    }

    /// Returns information about an audience model
    pub fn getAudienceModel(self: *Self, allocator: std.mem.Allocator, input: get_audience_model.GetAudienceModelInput, options: CallOptions) !get_audience_model.GetAudienceModelOutput {
        return get_audience_model.execute(self, allocator, input, options);
    }

    /// Returns information about the configured model algorithm association in a
    /// collaboration.
    pub fn getCollaborationConfiguredModelAlgorithmAssociation(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_configured_model_algorithm_association.GetCollaborationConfiguredModelAlgorithmAssociationInput, options: CallOptions) !get_collaboration_configured_model_algorithm_association.GetCollaborationConfiguredModelAlgorithmAssociationOutput {
        return get_collaboration_configured_model_algorithm_association.execute(self, allocator, input, options);
    }

    /// Returns information about a specific ML input channel in a collaboration.
    pub fn getCollaborationMlInputChannel(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_ml_input_channel.GetCollaborationMLInputChannelInput, options: CallOptions) !get_collaboration_ml_input_channel.GetCollaborationMLInputChannelOutput {
        return get_collaboration_ml_input_channel.execute(self, allocator, input, options);
    }

    /// Returns information about a trained model in a collaboration.
    pub fn getCollaborationTrainedModel(self: *Self, allocator: std.mem.Allocator, input: get_collaboration_trained_model.GetCollaborationTrainedModelInput, options: CallOptions) !get_collaboration_trained_model.GetCollaborationTrainedModelOutput {
        return get_collaboration_trained_model.execute(self, allocator, input, options);
    }

    /// Returns information about a specified configured audience model.
    pub fn getConfiguredAudienceModel(self: *Self, allocator: std.mem.Allocator, input: get_configured_audience_model.GetConfiguredAudienceModelInput, options: CallOptions) !get_configured_audience_model.GetConfiguredAudienceModelOutput {
        return get_configured_audience_model.execute(self, allocator, input, options);
    }

    /// Returns information about a configured audience model policy.
    pub fn getConfiguredAudienceModelPolicy(self: *Self, allocator: std.mem.Allocator, input: get_configured_audience_model_policy.GetConfiguredAudienceModelPolicyInput, options: CallOptions) !get_configured_audience_model_policy.GetConfiguredAudienceModelPolicyOutput {
        return get_configured_audience_model_policy.execute(self, allocator, input, options);
    }

    /// Returns information about a configured model algorithm.
    pub fn getConfiguredModelAlgorithm(self: *Self, allocator: std.mem.Allocator, input: get_configured_model_algorithm.GetConfiguredModelAlgorithmInput, options: CallOptions) !get_configured_model_algorithm.GetConfiguredModelAlgorithmOutput {
        return get_configured_model_algorithm.execute(self, allocator, input, options);
    }

    /// Returns information about a configured model algorithm association.
    pub fn getConfiguredModelAlgorithmAssociation(self: *Self, allocator: std.mem.Allocator, input: get_configured_model_algorithm_association.GetConfiguredModelAlgorithmAssociationInput, options: CallOptions) !get_configured_model_algorithm_association.GetConfiguredModelAlgorithmAssociationOutput {
        return get_configured_model_algorithm_association.execute(self, allocator, input, options);
    }

    /// Returns information about a specific ML configuration.
    pub fn getMlConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_ml_configuration.GetMLConfigurationInput, options: CallOptions) !get_ml_configuration.GetMLConfigurationOutput {
        return get_ml_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about an ML input channel.
    pub fn getMlInputChannel(self: *Self, allocator: std.mem.Allocator, input: get_ml_input_channel.GetMLInputChannelInput, options: CallOptions) !get_ml_input_channel.GetMLInputChannelOutput {
        return get_ml_input_channel.execute(self, allocator, input, options);
    }

    /// Returns information about a trained model.
    pub fn getTrainedModel(self: *Self, allocator: std.mem.Allocator, input: get_trained_model.GetTrainedModelInput, options: CallOptions) !get_trained_model.GetTrainedModelOutput {
        return get_trained_model.execute(self, allocator, input, options);
    }

    /// Returns information about a trained model inference job.
    pub fn getTrainedModelInferenceJob(self: *Self, allocator: std.mem.Allocator, input: get_trained_model_inference_job.GetTrainedModelInferenceJobInput, options: CallOptions) !get_trained_model_inference_job.GetTrainedModelInferenceJobOutput {
        return get_trained_model_inference_job.execute(self, allocator, input, options);
    }

    /// Returns information about a training dataset.
    pub fn getTrainingDataset(self: *Self, allocator: std.mem.Allocator, input: get_training_dataset.GetTrainingDatasetInput, options: CallOptions) !get_training_dataset.GetTrainingDatasetOutput {
        return get_training_dataset.execute(self, allocator, input, options);
    }

    /// Returns a list of the audience export jobs.
    pub fn listAudienceExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_audience_export_jobs.ListAudienceExportJobsInput, options: CallOptions) !list_audience_export_jobs.ListAudienceExportJobsOutput {
        return list_audience_export_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of audience generation jobs.
    pub fn listAudienceGenerationJobs(self: *Self, allocator: std.mem.Allocator, input: list_audience_generation_jobs.ListAudienceGenerationJobsInput, options: CallOptions) !list_audience_generation_jobs.ListAudienceGenerationJobsOutput {
        return list_audience_generation_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of audience models.
    pub fn listAudienceModels(self: *Self, allocator: std.mem.Allocator, input: list_audience_models.ListAudienceModelsInput, options: CallOptions) !list_audience_models.ListAudienceModelsOutput {
        return list_audience_models.execute(self, allocator, input, options);
    }

    /// Returns a list of the configured model algorithm associations in a
    /// collaboration.
    pub fn listCollaborationConfiguredModelAlgorithmAssociations(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_configured_model_algorithm_associations.ListCollaborationConfiguredModelAlgorithmAssociationsInput, options: CallOptions) !list_collaboration_configured_model_algorithm_associations.ListCollaborationConfiguredModelAlgorithmAssociationsOutput {
        return list_collaboration_configured_model_algorithm_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of the ML input channels in a collaboration.
    pub fn listCollaborationMlInputChannels(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_ml_input_channels.ListCollaborationMLInputChannelsInput, options: CallOptions) !list_collaboration_ml_input_channels.ListCollaborationMLInputChannelsOutput {
        return list_collaboration_ml_input_channels.execute(self, allocator, input, options);
    }

    /// Returns a list of the export jobs for a trained model in a collaboration.
    pub fn listCollaborationTrainedModelExportJobs(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_trained_model_export_jobs.ListCollaborationTrainedModelExportJobsInput, options: CallOptions) !list_collaboration_trained_model_export_jobs.ListCollaborationTrainedModelExportJobsOutput {
        return list_collaboration_trained_model_export_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of trained model inference jobs in a specified collaboration.
    pub fn listCollaborationTrainedModelInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_trained_model_inference_jobs.ListCollaborationTrainedModelInferenceJobsInput, options: CallOptions) !list_collaboration_trained_model_inference_jobs.ListCollaborationTrainedModelInferenceJobsOutput {
        return list_collaboration_trained_model_inference_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of the trained models in a collaboration.
    pub fn listCollaborationTrainedModels(self: *Self, allocator: std.mem.Allocator, input: list_collaboration_trained_models.ListCollaborationTrainedModelsInput, options: CallOptions) !list_collaboration_trained_models.ListCollaborationTrainedModelsOutput {
        return list_collaboration_trained_models.execute(self, allocator, input, options);
    }

    /// Returns a list of the configured audience models.
    pub fn listConfiguredAudienceModels(self: *Self, allocator: std.mem.Allocator, input: list_configured_audience_models.ListConfiguredAudienceModelsInput, options: CallOptions) !list_configured_audience_models.ListConfiguredAudienceModelsOutput {
        return list_configured_audience_models.execute(self, allocator, input, options);
    }

    /// Returns a list of configured model algorithm associations.
    pub fn listConfiguredModelAlgorithmAssociations(self: *Self, allocator: std.mem.Allocator, input: list_configured_model_algorithm_associations.ListConfiguredModelAlgorithmAssociationsInput, options: CallOptions) !list_configured_model_algorithm_associations.ListConfiguredModelAlgorithmAssociationsOutput {
        return list_configured_model_algorithm_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of configured model algorithms.
    pub fn listConfiguredModelAlgorithms(self: *Self, allocator: std.mem.Allocator, input: list_configured_model_algorithms.ListConfiguredModelAlgorithmsInput, options: CallOptions) !list_configured_model_algorithms.ListConfiguredModelAlgorithmsOutput {
        return list_configured_model_algorithms.execute(self, allocator, input, options);
    }

    /// Returns a list of ML input channels.
    pub fn listMlInputChannels(self: *Self, allocator: std.mem.Allocator, input: list_ml_input_channels.ListMLInputChannelsInput, options: CallOptions) !list_ml_input_channels.ListMLInputChannelsOutput {
        return list_ml_input_channels.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for a provided resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of trained model inference jobs that match the request
    /// parameters.
    pub fn listTrainedModelInferenceJobs(self: *Self, allocator: std.mem.Allocator, input: list_trained_model_inference_jobs.ListTrainedModelInferenceJobsInput, options: CallOptions) !list_trained_model_inference_jobs.ListTrainedModelInferenceJobsOutput {
        return list_trained_model_inference_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of trained model versions for a specified trained model. This
    /// operation allows you to view all versions of a trained model, including
    /// information about their status and creation details. You can use this to
    /// track the evolution of your trained models and select specific versions for
    /// inference or further training.
    pub fn listTrainedModelVersions(self: *Self, allocator: std.mem.Allocator, input: list_trained_model_versions.ListTrainedModelVersionsInput, options: CallOptions) !list_trained_model_versions.ListTrainedModelVersionsOutput {
        return list_trained_model_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of trained models.
    pub fn listTrainedModels(self: *Self, allocator: std.mem.Allocator, input: list_trained_models.ListTrainedModelsInput, options: CallOptions) !list_trained_models.ListTrainedModelsOutput {
        return list_trained_models.execute(self, allocator, input, options);
    }

    /// Returns a list of training datasets.
    pub fn listTrainingDatasets(self: *Self, allocator: std.mem.Allocator, input: list_training_datasets.ListTrainingDatasetsInput, options: CallOptions) !list_training_datasets.ListTrainingDatasetsOutput {
        return list_training_datasets.execute(self, allocator, input, options);
    }

    /// Create or update the resource policy for a configured audience model.
    pub fn putConfiguredAudienceModelPolicy(self: *Self, allocator: std.mem.Allocator, input: put_configured_audience_model_policy.PutConfiguredAudienceModelPolicyInput, options: CallOptions) !put_configured_audience_model_policy.PutConfiguredAudienceModelPolicyOutput {
        return put_configured_audience_model_policy.execute(self, allocator, input, options);
    }

    /// Assigns information about an ML configuration.
    pub fn putMlConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_ml_configuration.PutMLConfigurationInput, options: CallOptions) !put_ml_configuration.PutMLConfigurationOutput {
        return put_ml_configuration.execute(self, allocator, input, options);
    }

    /// Export an audience of a specified size after you have generated an audience.
    pub fn startAudienceExportJob(self: *Self, allocator: std.mem.Allocator, input: start_audience_export_job.StartAudienceExportJobInput, options: CallOptions) !start_audience_export_job.StartAudienceExportJobOutput {
        return start_audience_export_job.execute(self, allocator, input, options);
    }

    /// Information necessary to start the audience generation job.
    pub fn startAudienceGenerationJob(self: *Self, allocator: std.mem.Allocator, input: start_audience_generation_job.StartAudienceGenerationJobInput, options: CallOptions) !start_audience_generation_job.StartAudienceGenerationJobOutput {
        return start_audience_generation_job.execute(self, allocator, input, options);
    }

    /// Provides the information necessary to start a trained model export job.
    pub fn startTrainedModelExportJob(self: *Self, allocator: std.mem.Allocator, input: start_trained_model_export_job.StartTrainedModelExportJobInput, options: CallOptions) !start_trained_model_export_job.StartTrainedModelExportJobOutput {
        return start_trained_model_export_job.execute(self, allocator, input, options);
    }

    /// Defines the information necessary to begin a trained model inference job.
    pub fn startTrainedModelInferenceJob(self: *Self, allocator: std.mem.Allocator, input: start_trained_model_inference_job.StartTrainedModelInferenceJobInput, options: CallOptions) !start_trained_model_inference_job.StartTrainedModelInferenceJobOutput {
        return start_trained_model_inference_job.execute(self, allocator, input, options);
    }

    /// Adds metadata tags to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes metadata tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Provides the information necessary to update a configured audience model.
    /// Updates that impact audience generation jobs take effect when a new job
    /// starts, but do not impact currently running jobs.
    pub fn updateConfiguredAudienceModel(self: *Self, allocator: std.mem.Allocator, input: update_configured_audience_model.UpdateConfiguredAudienceModelInput, options: CallOptions) !update_configured_audience_model.UpdateConfiguredAudienceModelOutput {
        return update_configured_audience_model.execute(self, allocator, input, options);
    }

    pub fn listAudienceExportJobsPaginator(self: *Self, params: list_audience_export_jobs.ListAudienceExportJobsInput) paginator.ListAudienceExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAudienceGenerationJobsPaginator(self: *Self, params: list_audience_generation_jobs.ListAudienceGenerationJobsInput) paginator.ListAudienceGenerationJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAudienceModelsPaginator(self: *Self, params: list_audience_models.ListAudienceModelsInput) paginator.ListAudienceModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollaborationConfiguredModelAlgorithmAssociationsPaginator(self: *Self, params: list_collaboration_configured_model_algorithm_associations.ListCollaborationConfiguredModelAlgorithmAssociationsInput) paginator.ListCollaborationConfiguredModelAlgorithmAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollaborationMlInputChannelsPaginator(self: *Self, params: list_collaboration_ml_input_channels.ListCollaborationMLInputChannelsInput) paginator.ListCollaborationMLInputChannelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollaborationTrainedModelExportJobsPaginator(self: *Self, params: list_collaboration_trained_model_export_jobs.ListCollaborationTrainedModelExportJobsInput) paginator.ListCollaborationTrainedModelExportJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollaborationTrainedModelInferenceJobsPaginator(self: *Self, params: list_collaboration_trained_model_inference_jobs.ListCollaborationTrainedModelInferenceJobsInput) paginator.ListCollaborationTrainedModelInferenceJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCollaborationTrainedModelsPaginator(self: *Self, params: list_collaboration_trained_models.ListCollaborationTrainedModelsInput) paginator.ListCollaborationTrainedModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfiguredAudienceModelsPaginator(self: *Self, params: list_configured_audience_models.ListConfiguredAudienceModelsInput) paginator.ListConfiguredAudienceModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfiguredModelAlgorithmAssociationsPaginator(self: *Self, params: list_configured_model_algorithm_associations.ListConfiguredModelAlgorithmAssociationsInput) paginator.ListConfiguredModelAlgorithmAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConfiguredModelAlgorithmsPaginator(self: *Self, params: list_configured_model_algorithms.ListConfiguredModelAlgorithmsInput) paginator.ListConfiguredModelAlgorithmsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listMlInputChannelsPaginator(self: *Self, params: list_ml_input_channels.ListMLInputChannelsInput) paginator.ListMLInputChannelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTrainedModelInferenceJobsPaginator(self: *Self, params: list_trained_model_inference_jobs.ListTrainedModelInferenceJobsInput) paginator.ListTrainedModelInferenceJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTrainedModelVersionsPaginator(self: *Self, params: list_trained_model_versions.ListTrainedModelVersionsInput) paginator.ListTrainedModelVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTrainedModelsPaginator(self: *Self, params: list_trained_models.ListTrainedModelsInput) paginator.ListTrainedModelsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTrainingDatasetsPaginator(self: *Self, params: list_training_datasets.ListTrainingDatasetsInput) paginator.ListTrainingDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
