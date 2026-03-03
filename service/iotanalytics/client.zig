const aws = @import("aws");
const std = @import("std");

const batch_put_message = @import("batch_put_message.zig");
const cancel_pipeline_reprocessing = @import("cancel_pipeline_reprocessing.zig");
const create_channel = @import("create_channel.zig");
const create_dataset = @import("create_dataset.zig");
const create_dataset_content = @import("create_dataset_content.zig");
const create_datastore = @import("create_datastore.zig");
const create_pipeline = @import("create_pipeline.zig");
const delete_channel = @import("delete_channel.zig");
const delete_dataset = @import("delete_dataset.zig");
const delete_dataset_content = @import("delete_dataset_content.zig");
const delete_datastore = @import("delete_datastore.zig");
const delete_pipeline = @import("delete_pipeline.zig");
const describe_channel = @import("describe_channel.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_datastore = @import("describe_datastore.zig");
const describe_logging_options = @import("describe_logging_options.zig");
const describe_pipeline = @import("describe_pipeline.zig");
const get_dataset_content = @import("get_dataset_content.zig");
const list_channels = @import("list_channels.zig");
const list_dataset_contents = @import("list_dataset_contents.zig");
const list_datasets = @import("list_datasets.zig");
const list_datastores = @import("list_datastores.zig");
const list_pipelines = @import("list_pipelines.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_logging_options = @import("put_logging_options.zig");
const run_pipeline_activity = @import("run_pipeline_activity.zig");
const sample_channel_data = @import("sample_channel_data.zig");
const start_pipeline_reprocessing = @import("start_pipeline_reprocessing.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_dataset = @import("update_dataset.zig");
const update_datastore = @import("update_datastore.zig");
const update_pipeline = @import("update_pipeline.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoTAnalytics";

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

    /// Sends messages to a channel.
    pub fn batchPutMessage(self: *Self, allocator: std.mem.Allocator, input: batch_put_message.BatchPutMessageInput, options: batch_put_message.Options) !batch_put_message.BatchPutMessageOutput {
        return batch_put_message.execute(self, allocator, input, options);
    }

    /// Cancels the reprocessing of data through the pipeline.
    pub fn cancelPipelineReprocessing(self: *Self, allocator: std.mem.Allocator, input: cancel_pipeline_reprocessing.CancelPipelineReprocessingInput, options: cancel_pipeline_reprocessing.Options) !cancel_pipeline_reprocessing.CancelPipelineReprocessingOutput {
        return cancel_pipeline_reprocessing.execute(self, allocator, input, options);
    }

    /// Used to create a channel. A channel collects data from an MQTT topic and
    /// archives the raw,
    /// unprocessed messages before publishing the data to a pipeline.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Used to create a dataset. A dataset stores data retrieved from a data store
    /// by applying a
    /// `queryAction` (a SQL query) or a `containerAction` (executing a
    /// containerized application). This operation creates the skeleton of a
    /// dataset. The dataset can
    /// be populated manually by calling `CreateDatasetContent` or automatically
    /// according
    /// to a trigger you specify.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: create_dataset.Options) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates the content of a dataset by applying a `queryAction` (a SQL query)
    /// or a
    /// `containerAction` (executing a containerized application).
    pub fn createDatasetContent(self: *Self, allocator: std.mem.Allocator, input: create_dataset_content.CreateDatasetContentInput, options: create_dataset_content.Options) !create_dataset_content.CreateDatasetContentOutput {
        return create_dataset_content.execute(self, allocator, input, options);
    }

    /// Creates a data store, which is a repository for messages.
    pub fn createDatastore(self: *Self, allocator: std.mem.Allocator, input: create_datastore.CreateDatastoreInput, options: create_datastore.Options) !create_datastore.CreateDatastoreOutput {
        return create_datastore.execute(self, allocator, input, options);
    }

    /// Creates a pipeline. A pipeline consumes messages from a channel and allows
    /// you to process
    /// the messages before storing them in a data store. You must specify both a
    /// `channel`
    /// and a `datastore` activity and, optionally, as many as 23 additional
    /// activities in
    /// the `pipelineActivities` array.
    pub fn createPipeline(self: *Self, allocator: std.mem.Allocator, input: create_pipeline.CreatePipelineInput, options: create_pipeline.Options) !create_pipeline.CreatePipelineOutput {
        return create_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes the specified channel.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Deletes the specified dataset.
    ///
    /// You do not have to delete the content of the dataset before you perform this
    /// operation.
    pub fn deleteDataset(self: *Self, allocator: std.mem.Allocator, input: delete_dataset.DeleteDatasetInput, options: delete_dataset.Options) !delete_dataset.DeleteDatasetOutput {
        return delete_dataset.execute(self, allocator, input, options);
    }

    /// Deletes the content of the specified dataset.
    pub fn deleteDatasetContent(self: *Self, allocator: std.mem.Allocator, input: delete_dataset_content.DeleteDatasetContentInput, options: delete_dataset_content.Options) !delete_dataset_content.DeleteDatasetContentOutput {
        return delete_dataset_content.execute(self, allocator, input, options);
    }

    /// Deletes the specified data store.
    pub fn deleteDatastore(self: *Self, allocator: std.mem.Allocator, input: delete_datastore.DeleteDatastoreInput, options: delete_datastore.Options) !delete_datastore.DeleteDatastoreOutput {
        return delete_datastore.execute(self, allocator, input, options);
    }

    /// Deletes the specified pipeline.
    pub fn deletePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_pipeline.DeletePipelineInput, options: delete_pipeline.Options) !delete_pipeline.DeletePipelineOutput {
        return delete_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves information about a channel.
    pub fn describeChannel(self: *Self, allocator: std.mem.Allocator, input: describe_channel.DescribeChannelInput, options: describe_channel.Options) !describe_channel.DescribeChannelOutput {
        return describe_channel.execute(self, allocator, input, options);
    }

    /// Retrieves information about a dataset.
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: describe_dataset.Options) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Retrieves information about a data store.
    pub fn describeDatastore(self: *Self, allocator: std.mem.Allocator, input: describe_datastore.DescribeDatastoreInput, options: describe_datastore.Options) !describe_datastore.DescribeDatastoreOutput {
        return describe_datastore.execute(self, allocator, input, options);
    }

    /// Retrieves the current settings of the IoT Analytics logging options.
    pub fn describeLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: describe_logging_options.DescribeLoggingOptionsInput, options: describe_logging_options.Options) !describe_logging_options.DescribeLoggingOptionsOutput {
        return describe_logging_options.execute(self, allocator, input, options);
    }

    /// Retrieves information about a pipeline.
    pub fn describePipeline(self: *Self, allocator: std.mem.Allocator, input: describe_pipeline.DescribePipelineInput, options: describe_pipeline.Options) !describe_pipeline.DescribePipelineOutput {
        return describe_pipeline.execute(self, allocator, input, options);
    }

    /// Retrieves the contents of a dataset as presigned URIs.
    pub fn getDatasetContent(self: *Self, allocator: std.mem.Allocator, input: get_dataset_content.GetDatasetContentInput, options: get_dataset_content.Options) !get_dataset_content.GetDatasetContentOutput {
        return get_dataset_content.execute(self, allocator, input, options);
    }

    /// Retrieves a list of channels.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Lists information about dataset contents that have been created.
    pub fn listDatasetContents(self: *Self, allocator: std.mem.Allocator, input: list_dataset_contents.ListDatasetContentsInput, options: list_dataset_contents.Options) !list_dataset_contents.ListDatasetContentsOutput {
        return list_dataset_contents.execute(self, allocator, input, options);
    }

    /// Retrieves information about datasets.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: list_datasets.Options) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Retrieves a list of data stores.
    pub fn listDatastores(self: *Self, allocator: std.mem.Allocator, input: list_datastores.ListDatastoresInput, options: list_datastores.Options) !list_datastores.ListDatastoresOutput {
        return list_datastores.execute(self, allocator, input, options);
    }

    /// Retrieves a list of pipelines.
    pub fn listPipelines(self: *Self, allocator: std.mem.Allocator, input: list_pipelines.ListPipelinesInput, options: list_pipelines.Options) !list_pipelines.ListPipelinesOutput {
        return list_pipelines.execute(self, allocator, input, options);
    }

    /// Lists the tags (metadata) that you have assigned to the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets or updates the IoT Analytics logging options.
    ///
    /// If you update the value of any `loggingOptions` field, it takes up to one
    /// minute for the change to take effect. Also, if you change the policy
    /// attached to the role you
    /// specified in the `roleArn` field (for example, to correct an invalid
    /// policy), it
    /// takes up to five minutes for that change to take effect.
    pub fn putLoggingOptions(self: *Self, allocator: std.mem.Allocator, input: put_logging_options.PutLoggingOptionsInput, options: put_logging_options.Options) !put_logging_options.PutLoggingOptionsOutput {
        return put_logging_options.execute(self, allocator, input, options);
    }

    /// Simulates the results of running a pipeline activity on a message payload.
    pub fn runPipelineActivity(self: *Self, allocator: std.mem.Allocator, input: run_pipeline_activity.RunPipelineActivityInput, options: run_pipeline_activity.Options) !run_pipeline_activity.RunPipelineActivityOutput {
        return run_pipeline_activity.execute(self, allocator, input, options);
    }

    /// Retrieves a sample of messages from the specified channel ingested during
    /// the specified
    /// timeframe. Up to 10 messages can be retrieved.
    pub fn sampleChannelData(self: *Self, allocator: std.mem.Allocator, input: sample_channel_data.SampleChannelDataInput, options: sample_channel_data.Options) !sample_channel_data.SampleChannelDataOutput {
        return sample_channel_data.execute(self, allocator, input, options);
    }

    /// Starts the reprocessing of raw message data through the pipeline.
    pub fn startPipelineReprocessing(self: *Self, allocator: std.mem.Allocator, input: start_pipeline_reprocessing.StartPipelineReprocessingInput, options: start_pipeline_reprocessing.Options) !start_pipeline_reprocessing.StartPipelineReprocessingOutput {
        return start_pipeline_reprocessing.execute(self, allocator, input, options);
    }

    /// Adds to or modifies the tags of the given resource. Tags are metadata that
    /// can be used to
    /// manage a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the given tags (metadata) from the resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Used to update the settings of a channel.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Updates the settings of a dataset.
    pub fn updateDataset(self: *Self, allocator: std.mem.Allocator, input: update_dataset.UpdateDatasetInput, options: update_dataset.Options) !update_dataset.UpdateDatasetOutput {
        return update_dataset.execute(self, allocator, input, options);
    }

    /// Used to update the settings of a data store.
    pub fn updateDatastore(self: *Self, allocator: std.mem.Allocator, input: update_datastore.UpdateDatastoreInput, options: update_datastore.Options) !update_datastore.UpdateDatastoreOutput {
        return update_datastore.execute(self, allocator, input, options);
    }

    /// Updates the settings of a pipeline. You must specify both a `channel` and a
    /// `datastore` activity and, optionally, as many as 23 additional activities in
    /// the
    /// `pipelineActivities` array.
    pub fn updatePipeline(self: *Self, allocator: std.mem.Allocator, input: update_pipeline.UpdatePipelineInput, options: update_pipeline.Options) !update_pipeline.UpdatePipelineOutput {
        return update_pipeline.execute(self, allocator, input, options);
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDatasetContentsPaginator(self: *Self, params: list_dataset_contents.ListDatasetContentsInput) paginator.ListDatasetContentsPaginator {
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

    pub fn listDatastoresPaginator(self: *Self, params: list_datastores.ListDatastoresInput) paginator.ListDatastoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPipelinesPaginator(self: *Self, params: list_pipelines.ListPipelinesInput) paginator.ListPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
