const aws = @import("aws");
const std = @import("std");

const create_dataset = @import("create_dataset.zig");
const create_inference_scheduler = @import("create_inference_scheduler.zig");
const create_label = @import("create_label.zig");
const create_label_group = @import("create_label_group.zig");
const create_model = @import("create_model.zig");
const create_retraining_scheduler = @import("create_retraining_scheduler.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_inference_scheduler = @import("delete_inference_scheduler.zig");
const delete_label = @import("delete_label.zig");
const delete_label_group = @import("delete_label_group.zig");
const delete_model = @import("delete_model.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_retraining_scheduler = @import("delete_retraining_scheduler.zig");
const describe_data_ingestion_job = @import("describe_data_ingestion_job.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_inference_scheduler = @import("describe_inference_scheduler.zig");
const describe_label = @import("describe_label.zig");
const describe_label_group = @import("describe_label_group.zig");
const describe_model = @import("describe_model.zig");
const describe_model_version = @import("describe_model_version.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_retraining_scheduler = @import("describe_retraining_scheduler.zig");
const import_dataset = @import("import_dataset.zig");
const import_model_version = @import("import_model_version.zig");
const list_data_ingestion_jobs = @import("list_data_ingestion_jobs.zig");
const list_datasets = @import("list_datasets.zig");
const list_inference_events = @import("list_inference_events.zig");
const list_inference_executions = @import("list_inference_executions.zig");
const list_inference_schedulers = @import("list_inference_schedulers.zig");
const list_label_groups = @import("list_label_groups.zig");
const list_labels = @import("list_labels.zig");
const list_model_versions = @import("list_model_versions.zig");
const list_models = @import("list_models.zig");
const list_retraining_schedulers = @import("list_retraining_schedulers.zig");
const list_sensor_statistics = @import("list_sensor_statistics.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const start_data_ingestion_job = @import("start_data_ingestion_job.zig");
const start_inference_scheduler = @import("start_inference_scheduler.zig");
const start_retraining_scheduler = @import("start_retraining_scheduler.zig");
const stop_inference_scheduler = @import("stop_inference_scheduler.zig");
const stop_retraining_scheduler = @import("stop_retraining_scheduler.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_active_model_version = @import("update_active_model_version.zig");
const update_inference_scheduler = @import("update_inference_scheduler.zig");
const update_label_group = @import("update_label_group.zig");
const update_model = @import("update_model.zig");
const update_retraining_scheduler = @import("update_retraining_scheduler.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "LookoutEquipment";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a container for a collection of data being ingested for analysis.
    /// The dataset
    /// contains the metadata describing where the data is and what the data
    /// actually looks like.
    /// For example, it contains the location of the data source, the data schema,
    /// and other
    /// information. A dataset also contains any tags associated with the ingested
    /// data.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: create_dataset.Options) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a scheduled inference. Scheduling an inference is setting up a
    /// continuous
    /// real-time inference plan to analyze new measurement data. When setting up
    /// the schedule, you
    /// provide an S3 bucket location for the input data, assign it a delimiter
    /// between separate
    /// entries in the data, set an offset delay if desired, and set the frequency
    /// of inferencing.
    /// You must also provide an S3 bucket location for the output data.
    pub fn createInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: create_inference_scheduler.CreateInferenceSchedulerInput, options: create_inference_scheduler.Options) !create_inference_scheduler.CreateInferenceSchedulerOutput {
        return create_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Creates a label for an event.
    pub fn createLabel(self: *Self, allocator: std.mem.Allocator, input: create_label.CreateLabelInput, options: create_label.Options) !create_label.CreateLabelOutput {
        return create_label.execute(self, allocator, input, options);
    }

    /// Creates a group of labels.
    pub fn createLabelGroup(self: *Self, allocator: std.mem.Allocator, input: create_label_group.CreateLabelGroupInput, options: create_label_group.Options) !create_label_group.CreateLabelGroupOutput {
        return create_label_group.execute(self, allocator, input, options);
    }

    /// Creates a machine learning model for data inference.
    ///
    /// A machine-learning (ML) model is a mathematical model that finds patterns in
    /// your data.
    /// In Amazon Lookout for Equipment, the model learns the patterns of normal
    /// behavior and detects abnormal
    /// behavior that could be potential equipment failure (or maintenance events).
    /// The models are
    /// made by analyzing normal data and abnormalities in machine behavior that
    /// have already
    /// occurred.
    ///
    /// Your model is trained using a portion of the data from your dataset and uses
    /// that data
    /// to learn patterns of normal behavior and abnormal patterns that lead to
    /// equipment failure.
    /// Another portion of the data is used to evaluate the model's accuracy.
    pub fn createModel(self: *Self, allocator: std.mem.Allocator, input: create_model.CreateModelInput, options: create_model.Options) !create_model.CreateModelOutput {
        return create_model.execute(self, allocator, input, options);
    }

    /// Creates a retraining scheduler on the specified model.
    pub fn createRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: create_retraining_scheduler.CreateRetrainingSchedulerInput, options: create_retraining_scheduler.Options) !create_retraining_scheduler.CreateRetrainingSchedulerOutput {
        return create_retraining_scheduler.execute(self, allocator, input, options);
    }

    /// Deletes a dataset and associated artifacts. The operation will check to see
    /// if any
    /// inference scheduler or data ingestion job is currently using the dataset,
    /// and if there
    /// isn't, the dataset, its metadata, and any associated data stored in S3 will
    /// be deleted.
    /// This does not affect any models that used this dataset for training and
    /// evaluation, but
    /// does prevent it from being used in the future.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: delete_dataset.Options) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes an inference scheduler that has been set up. Prior inference results
    /// will not be
    /// deleted.
    pub fn deleteInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: delete_inference_scheduler.DeleteInferenceSchedulerInput, options: delete_inference_scheduler.Options) !delete_inference_scheduler.DeleteInferenceSchedulerOutput {
        return delete_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Deletes a label.
    pub fn deleteLabel(self: *Self, allocator: std.mem.Allocator, input: delete_label.DeleteLabelInput, options: delete_label.Options) !delete_label.DeleteLabelOutput {
        return delete_label.execute(self, allocator, input, options);
    }

    /// Deletes a group of labels.
    pub fn deleteLabelGroup(self: *Self, allocator: std.mem.Allocator, input: delete_label_group.DeleteLabelGroupInput, options: delete_label_group.Options) !delete_label_group.DeleteLabelGroupOutput {
        return delete_label_group.execute(self, allocator, input, options);
    }

    /// Deletes a machine learning model currently available for Amazon Lookout for
    /// Equipment. This will prevent it
    /// from being used with an inference scheduler, even one that is already set
    /// up.
    pub fn deleteModel(self: *Self, allocator: std.mem.Allocator, input: delete_model.DeleteModelInput, options: delete_model.Options) !delete_model.DeleteModelOutput {
        return delete_model.execute(self, allocator, input, options);
    }

    /// Deletes the resource policy attached to the resource.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a retraining scheduler from a model. The retraining scheduler must
    /// be in the
    /// `STOPPED` status.
    pub fn deleteRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: delete_retraining_scheduler.DeleteRetrainingSchedulerInput, options: delete_retraining_scheduler.Options) !delete_retraining_scheduler.DeleteRetrainingSchedulerOutput {
        return delete_retraining_scheduler.execute(self, allocator, input, options);
    }

    /// Provides information on a specific data ingestion job such as creation time,
    /// dataset
    /// ARN, and status.
    pub fn describeDataIngestionJob(self: *Self, allocator: std.mem.Allocator, input: describe_data_ingestion_job.DescribeDataIngestionJobInput, options: describe_data_ingestion_job.Options) !describe_data_ingestion_job.DescribeDataIngestionJobOutput {
        return describe_data_ingestion_job.execute(self, allocator, input, options);
    }

    /// Provides a JSON description of the data in each time series dataset,
    /// including names,
    /// column names, and data types.
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: describe_dataset.Options) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Specifies information about the inference scheduler being used, including
    /// name, model,
    /// status, and associated metadata
    pub fn describeInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: describe_inference_scheduler.DescribeInferenceSchedulerInput, options: describe_inference_scheduler.Options) !describe_inference_scheduler.DescribeInferenceSchedulerOutput {
        return describe_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Returns the name of the label.
    pub fn describeLabel(self: *Self, allocator: std.mem.Allocator, input: describe_label.DescribeLabelInput, options: describe_label.Options) !describe_label.DescribeLabelOutput {
        return describe_label.execute(self, allocator, input, options);
    }

    /// Returns information about the label group.
    pub fn describeLabelGroup(self: *Self, allocator: std.mem.Allocator, input: describe_label_group.DescribeLabelGroupInput, options: describe_label_group.Options) !describe_label_group.DescribeLabelGroupOutput {
        return describe_label_group.execute(self, allocator, input, options);
    }

    /// Provides a JSON containing the overall information about a specific machine
    /// learning
    /// model, including model name and ARN, dataset, training and evaluation
    /// information, status,
    /// and so on.
    pub fn describeModel(self: *Self, allocator: std.mem.Allocator, input: describe_model.DescribeModelInput, options: describe_model.Options) !describe_model.DescribeModelOutput {
        return describe_model.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific machine learning model version.
    pub fn describeModelVersion(self: *Self, allocator: std.mem.Allocator, input: describe_model_version.DescribeModelVersionInput, options: describe_model_version.Options) !describe_model_version.DescribeModelVersionOutput {
        return describe_model_version.execute(self, allocator, input, options);
    }

    /// Provides the details of a resource policy attached to a resource.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: describe_resource_policy.Options) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Provides a description of the retraining scheduler, including information
    /// such as the
    /// model name and retraining parameters.
    pub fn describeRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: describe_retraining_scheduler.DescribeRetrainingSchedulerInput, options: describe_retraining_scheduler.Options) !describe_retraining_scheduler.DescribeRetrainingSchedulerOutput {
        return describe_retraining_scheduler.execute(self, allocator, input, options);
    }

    /// Imports a dataset.
    pub fn importDataset(self: *Self, allocator: std.mem.Allocator, input: import_dataset.ImportDatasetInput, options: import_dataset.Options) !import_dataset.ImportDatasetOutput {
        return import_dataset.execute(self, allocator, input, options);
    }

    /// Imports a model that has been trained successfully.
    pub fn importModelVersion(self: *Self, allocator: std.mem.Allocator, input: import_model_version.ImportModelVersionInput, options: import_model_version.Options) !import_model_version.ImportModelVersionOutput {
        return import_model_version.execute(self, allocator, input, options);
    }

    /// Provides a list of all data ingestion jobs, including dataset name and ARN,
    /// S3 location
    /// of the input data, status, and so on.
    pub fn listDataIngestionJobs(self: *Self, allocator: std.mem.Allocator, input: list_data_ingestion_jobs.ListDataIngestionJobsInput, options: list_data_ingestion_jobs.Options) !list_data_ingestion_jobs.ListDataIngestionJobsOutput {
        return list_data_ingestion_jobs.execute(self, allocator, input, options);
    }

    /// Lists all datasets currently available in your account, filtering on the
    /// dataset name.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: list_datasets.Options) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Lists all inference events that have been found for the specified inference
    /// scheduler.
    pub fn listInferenceEvents(self: *Self, allocator: std.mem.Allocator, input: list_inference_events.ListInferenceEventsInput, options: list_inference_events.Options) !list_inference_events.ListInferenceEventsOutput {
        return list_inference_events.execute(self, allocator, input, options);
    }

    /// Lists all inference executions that have been performed by the specified
    /// inference
    /// scheduler.
    pub fn listInferenceExecutions(self: *Self, allocator: std.mem.Allocator, input: list_inference_executions.ListInferenceExecutionsInput, options: list_inference_executions.Options) !list_inference_executions.ListInferenceExecutionsOutput {
        return list_inference_executions.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all inference schedulers currently available for your
    /// account.
    pub fn listInferenceSchedulers(self: *Self, allocator: std.mem.Allocator, input: list_inference_schedulers.ListInferenceSchedulersInput, options: list_inference_schedulers.Options) !list_inference_schedulers.ListInferenceSchedulersOutput {
        return list_inference_schedulers.execute(self, allocator, input, options);
    }

    /// Returns a list of the label groups.
    pub fn listLabelGroups(self: *Self, allocator: std.mem.Allocator, input: list_label_groups.ListLabelGroupsInput, options: list_label_groups.Options) !list_label_groups.ListLabelGroupsOutput {
        return list_label_groups.execute(self, allocator, input, options);
    }

    /// Provides a list of labels.
    pub fn listLabels(self: *Self, allocator: std.mem.Allocator, input: list_labels.ListLabelsInput, options: list_labels.Options) !list_labels.ListLabelsOutput {
        return list_labels.execute(self, allocator, input, options);
    }

    /// Generates a list of all model versions for a given model, including the
    /// model version,
    /// model version ARN, and status. To list a subset of versions, use the
    /// `MaxModelVersion` and `MinModelVersion` fields.
    pub fn listModelVersions(self: *Self, allocator: std.mem.Allocator, input: list_model_versions.ListModelVersionsInput, options: list_model_versions.Options) !list_model_versions.ListModelVersionsOutput {
        return list_model_versions.execute(self, allocator, input, options);
    }

    /// Generates a list of all models in the account, including model name and ARN,
    /// dataset,
    /// and status.
    pub fn listModels(self: *Self, allocator: std.mem.Allocator, input: list_models.ListModelsInput, options: list_models.Options) !list_models.ListModelsOutput {
        return list_models.execute(self, allocator, input, options);
    }

    /// Lists all retraining schedulers in your account, filtering by model name
    /// prefix and
    /// status.
    pub fn listRetrainingSchedulers(self: *Self, allocator: std.mem.Allocator, input: list_retraining_schedulers.ListRetrainingSchedulersInput, options: list_retraining_schedulers.Options) !list_retraining_schedulers.ListRetrainingSchedulersOutput {
        return list_retraining_schedulers.execute(self, allocator, input, options);
    }

    /// Lists statistics about the data collected for each of the sensors that have
    /// been
    /// successfully ingested in the particular dataset. Can also be used to
    /// retreive Sensor
    /// Statistics for a previous ingestion job.
    pub fn listSensorStatistics(self: *Self, allocator: std.mem.Allocator, input: list_sensor_statistics.ListSensorStatisticsInput, options: list_sensor_statistics.Options) !list_sensor_statistics.ListSensorStatisticsOutput {
        return list_sensor_statistics.execute(self, allocator, input, options);
    }

    /// Lists all the tags for a specified resource, including key and value.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates a resource control policy for a given resource.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Starts a data ingestion job. Amazon Lookout for Equipment returns the job
    /// status.
    pub fn startDataIngestionJob(self: *Self, allocator: std.mem.Allocator, input: start_data_ingestion_job.StartDataIngestionJobInput, options: start_data_ingestion_job.Options) !start_data_ingestion_job.StartDataIngestionJobOutput {
        return start_data_ingestion_job.execute(self, allocator, input, options);
    }

    /// Starts an inference scheduler.
    pub fn startInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: start_inference_scheduler.StartInferenceSchedulerInput, options: start_inference_scheduler.Options) !start_inference_scheduler.StartInferenceSchedulerOutput {
        return start_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Starts a retraining scheduler.
    pub fn startRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: start_retraining_scheduler.StartRetrainingSchedulerInput, options: start_retraining_scheduler.Options) !start_retraining_scheduler.StartRetrainingSchedulerOutput {
        return start_retraining_scheduler.execute(self, allocator, input, options);
    }

    /// Stops an inference scheduler.
    pub fn stopInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: stop_inference_scheduler.StopInferenceSchedulerInput, options: stop_inference_scheduler.Options) !stop_inference_scheduler.StopInferenceSchedulerOutput {
        return stop_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Stops a retraining scheduler.
    pub fn stopRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: stop_retraining_scheduler.StopRetrainingSchedulerInput, options: stop_retraining_scheduler.Options) !stop_retraining_scheduler.StopRetrainingSchedulerOutput {
        return stop_retraining_scheduler.execute(self, allocator, input, options);
    }

    /// Associates a given tag to a resource in your account. A tag is a key-value
    /// pair which
    /// can be added to an Amazon Lookout for Equipment resource as metadata. Tags
    /// can be used for organizing your
    /// resources as well as helping you to search and filter by tag. Multiple tags
    /// can be added to
    /// a resource, either when you create it, or later. Up to 50 tags can be
    /// associated with each
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a specific tag from a given resource. The tag is specified by its
    /// key.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Sets the active model version for a given machine learning model.
    pub fn updateActiveModelVersion(self: *Self, allocator: std.mem.Allocator, input: update_active_model_version.UpdateActiveModelVersionInput, options: update_active_model_version.Options) !update_active_model_version.UpdateActiveModelVersionOutput {
        return update_active_model_version.execute(self, allocator, input, options);
    }

    /// Updates an inference scheduler.
    pub fn updateInferenceScheduler(self: *Self, allocator: std.mem.Allocator, input: update_inference_scheduler.UpdateInferenceSchedulerInput, options: update_inference_scheduler.Options) !update_inference_scheduler.UpdateInferenceSchedulerOutput {
        return update_inference_scheduler.execute(self, allocator, input, options);
    }

    /// Updates the label group.
    pub fn updateLabelGroup(self: *Self, allocator: std.mem.Allocator, input: update_label_group.UpdateLabelGroupInput, options: update_label_group.Options) !update_label_group.UpdateLabelGroupOutput {
        return update_label_group.execute(self, allocator, input, options);
    }

    /// Updates a model in the account.
    pub fn updateModel(self: *Self, allocator: std.mem.Allocator, input: update_model.UpdateModelInput, options: update_model.Options) !update_model.UpdateModelOutput {
        return update_model.execute(self, allocator, input, options);
    }

    /// Updates a retraining scheduler.
    pub fn updateRetrainingScheduler(self: *Self, allocator: std.mem.Allocator, input: update_retraining_scheduler.UpdateRetrainingSchedulerInput, options: update_retraining_scheduler.Options) !update_retraining_scheduler.UpdateRetrainingSchedulerOutput {
        return update_retraining_scheduler.execute(self, allocator, input, options);
    }

    pub fn listDataIngestionJobsPaginator(self: *Self, params: list_data_ingestion_jobs.ListDataIngestionJobsInput) paginator.ListDataIngestionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceEventsPaginator(self: *Self, params: list_inference_events.ListInferenceEventsInput) paginator.ListInferenceEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceExecutionsPaginator(self: *Self, params: list_inference_executions.ListInferenceExecutionsInput) paginator.ListInferenceExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInferenceSchedulersPaginator(self: *Self, params: list_inference_schedulers.ListInferenceSchedulersInput) paginator.ListInferenceSchedulersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLabelGroupsPaginator(self: *Self, params: list_label_groups.ListLabelGroupsInput) paginator.ListLabelGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLabelsPaginator(self: *Self, params: list_labels.ListLabelsInput) paginator.ListLabelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelVersionsPaginator(self: *Self, params: list_model_versions.ListModelVersionsInput) paginator.ListModelVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listModelsPaginator(self: *Self, params: list_models.ListModelsInput) paginator.ListModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRetrainingSchedulersPaginator(self: *Self, params: list_retraining_schedulers.ListRetrainingSchedulersInput) paginator.ListRetrainingSchedulersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSensorStatisticsPaginator(self: *Self, params: list_sensor_statistics.ListSensorStatisticsInput) paginator.ListSensorStatisticsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
