const aws = @import("aws");
const std = @import("std");

const associate_configuration_items_to_application = @import("associate_configuration_items_to_application.zig");
const batch_delete_agents = @import("batch_delete_agents.zig");
const batch_delete_import_data = @import("batch_delete_import_data.zig");
const create_application = @import("create_application.zig");
const create_tags = @import("create_tags.zig");
const delete_applications = @import("delete_applications.zig");
const delete_tags = @import("delete_tags.zig");
const describe_agents = @import("describe_agents.zig");
const describe_batch_delete_configuration_task = @import("describe_batch_delete_configuration_task.zig");
const describe_configurations = @import("describe_configurations.zig");
const describe_continuous_exports = @import("describe_continuous_exports.zig");
const describe_export_configurations = @import("describe_export_configurations.zig");
const describe_export_tasks = @import("describe_export_tasks.zig");
const describe_import_tasks = @import("describe_import_tasks.zig");
const describe_tags = @import("describe_tags.zig");
const disassociate_configuration_items_from_application = @import("disassociate_configuration_items_from_application.zig");
const export_configurations = @import("export_configurations.zig");
const get_discovery_summary = @import("get_discovery_summary.zig");
const list_configurations = @import("list_configurations.zig");
const list_server_neighbors = @import("list_server_neighbors.zig");
const start_batch_delete_configuration_task = @import("start_batch_delete_configuration_task.zig");
const start_continuous_export = @import("start_continuous_export.zig");
const start_data_collection_by_agent_ids = @import("start_data_collection_by_agent_ids.zig");
const start_export_task = @import("start_export_task.zig");
const start_import_task = @import("start_import_task.zig");
const stop_continuous_export = @import("stop_continuous_export.zig");
const stop_data_collection_by_agent_ids = @import("stop_data_collection_by_agent_ids.zig");
const update_application = @import("update_application.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Application Discovery Service";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Associates one or more configuration items with an application.
    pub fn associateConfigurationItemsToApplication(self: *Self, allocator: std.mem.Allocator, input: associate_configuration_items_to_application.AssociateConfigurationItemsToApplicationInput, options: associate_configuration_items_to_application.Options) !associate_configuration_items_to_application.AssociateConfigurationItemsToApplicationOutput {
        return associate_configuration_items_to_application.execute(self, allocator, input, options);
    }

    /// Deletes one or more agents or collectors as specified by ID. Deleting an
    /// agent or collector does not
    /// delete the previously discovered data.
    /// To delete the data collected, use `StartBatchDeleteConfigurationTask`.
    pub fn batchDeleteAgents(self: *Self, allocator: std.mem.Allocator, input: batch_delete_agents.BatchDeleteAgentsInput, options: batch_delete_agents.Options) !batch_delete_agents.BatchDeleteAgentsOutput {
        return batch_delete_agents.execute(self, allocator, input, options);
    }

    /// Deletes one or more import tasks, each identified by their import ID. Each
    /// import task has
    /// a number of records that can identify servers or applications.
    ///
    /// Amazon Web Services Application Discovery Service has built-in matching
    /// logic that will identify when
    /// discovered servers match existing entries that you've previously discovered,
    /// the information
    /// for the already-existing discovered server is updated. When you delete an
    /// import task that
    /// contains records that were used to match, the information in those matched
    /// records that comes
    /// from the deleted records will also be deleted.
    pub fn batchDeleteImportData(self: *Self, allocator: std.mem.Allocator, input: batch_delete_import_data.BatchDeleteImportDataInput, options: batch_delete_import_data.Options) !batch_delete_import_data.BatchDeleteImportDataOutput {
        return batch_delete_import_data.execute(self, allocator, input, options);
    }

    /// Creates an application with the given name and description.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates one or more tags for configuration items. Tags are metadata that
    /// help you
    /// categorize IT assets. This API accepts a list of multiple configuration
    /// items.
    ///
    /// Do not store sensitive information (like personal data) in tags.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: create_tags.Options) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Deletes a list of applications and their associations with configuration
    /// items.
    pub fn deleteApplications(self: *Self, allocator: std.mem.Allocator, input: delete_applications.DeleteApplicationsInput, options: delete_applications.Options) !delete_applications.DeleteApplicationsOutput {
        return delete_applications.execute(self, allocator, input, options);
    }

    /// Deletes the association between configuration items and one or more tags.
    /// This API
    /// accepts a list of multiple configuration items.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: delete_tags.Options) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Lists agents or collectors as specified by ID or other filters. All
    /// agents/collectors
    /// associated with your user can be listed if you call `DescribeAgents` as is
    /// without passing any parameters.
    pub fn describeAgents(self: *Self, allocator: std.mem.Allocator, input: describe_agents.DescribeAgentsInput, options: describe_agents.Options) !describe_agents.DescribeAgentsOutput {
        return describe_agents.execute(self, allocator, input, options);
    }

    /// Takes a unique deletion task identifier as input and returns metadata about
    /// a configuration deletion task.
    pub fn describeBatchDeleteConfigurationTask(self: *Self, allocator: std.mem.Allocator, input: describe_batch_delete_configuration_task.DescribeBatchDeleteConfigurationTaskInput, options: describe_batch_delete_configuration_task.Options) !describe_batch_delete_configuration_task.DescribeBatchDeleteConfigurationTaskOutput {
        return describe_batch_delete_configuration_task.execute(self, allocator, input, options);
    }

    /// Retrieves attributes for a list of configuration item IDs.
    ///
    /// All of the supplied IDs must be for the same asset type from one of the
    /// following:
    ///
    /// * server
    ///
    /// * application
    ///
    /// * process
    ///
    /// * connection
    ///
    /// Output fields are specific to the asset type specified. For example, the
    /// output for a
    /// *server* configuration item includes a list of attributes about the
    /// server, such as host name, operating system, number of network cards, etc.
    ///
    /// For a complete list of outputs for each asset type, see [Using the
    /// DescribeConfigurations
    /// Action](https://docs.aws.amazon.com/application-discovery/latest/userguide/discovery-api-queries.html#DescribeConfigurations) in the *Amazon Web Services Application
    /// Discovery Service User Guide*.
    pub fn describeConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_configurations.DescribeConfigurationsInput, options: describe_configurations.Options) !describe_configurations.DescribeConfigurationsOutput {
        return describe_configurations.execute(self, allocator, input, options);
    }

    /// Lists exports as specified by ID. All continuous exports associated with
    /// your user
    /// can be listed if you call `DescribeContinuousExports` as is without passing
    /// any parameters.
    pub fn describeContinuousExports(self: *Self, allocator: std.mem.Allocator, input: describe_continuous_exports.DescribeContinuousExportsInput, options: describe_continuous_exports.Options) !describe_continuous_exports.DescribeContinuousExportsOutput {
        return describe_continuous_exports.execute(self, allocator, input, options);
    }

    /// `DescribeExportConfigurations` is deprecated. Use
    /// [DescribeExportTasks](https://docs.aws.amazon.com/application-discovery/latest/APIReference/API_DescribeExportTasks.html), instead.
    pub fn describeExportConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_export_configurations.DescribeExportConfigurationsInput, options: describe_export_configurations.Options) !describe_export_configurations.DescribeExportConfigurationsOutput {
        return describe_export_configurations.execute(self, allocator, input, options);
    }

    /// Retrieve status of one or more export tasks. You can retrieve the status of
    /// up to 100
    /// export tasks.
    pub fn describeExportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_export_tasks.DescribeExportTasksInput, options: describe_export_tasks.Options) !describe_export_tasks.DescribeExportTasksOutput {
        return describe_export_tasks.execute(self, allocator, input, options);
    }

    /// Returns an array of import tasks for your account, including status
    /// information, times,
    /// IDs, the Amazon S3 Object URL for the import file, and more.
    pub fn describeImportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_import_tasks.DescribeImportTasksInput, options: describe_import_tasks.Options) !describe_import_tasks.DescribeImportTasksOutput {
        return describe_import_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a list of configuration items that have tags as specified by the
    /// key-value
    /// pairs, name and value, passed to the optional parameter `filters`.
    ///
    /// There are three valid tag filter names:
    ///
    /// * tagKey
    ///
    /// * tagValue
    ///
    /// * configurationId
    ///
    /// Also, all configuration items associated with your user that have tags can
    /// be
    /// listed if you call `DescribeTags` as is without passing any parameters.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: describe_tags.Options) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Disassociates one or more configuration items from an application.
    pub fn disassociateConfigurationItemsFromApplication(self: *Self, allocator: std.mem.Allocator, input: disassociate_configuration_items_from_application.DisassociateConfigurationItemsFromApplicationInput, options: disassociate_configuration_items_from_application.Options) !disassociate_configuration_items_from_application.DisassociateConfigurationItemsFromApplicationOutput {
        return disassociate_configuration_items_from_application.execute(self, allocator, input, options);
    }

    /// Deprecated. Use `StartExportTask` instead.
    ///
    /// Exports all discovered configuration data to an Amazon S3 bucket or an
    /// application that
    /// enables you to view and evaluate the data. Data includes tags and tag
    /// associations, processes,
    /// connections, servers, and system performance. This API returns an export ID
    /// that you can query
    /// using the *DescribeExportConfigurations* API. The system imposes a limit of
    /// two configuration exports in six hours.
    pub fn exportConfigurations(self: *Self, allocator: std.mem.Allocator, input: export_configurations.ExportConfigurationsInput, options: export_configurations.Options) !export_configurations.ExportConfigurationsOutput {
        return export_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves a short summary of discovered assets.
    ///
    /// This API operation takes no request parameters and is called as is at the
    /// command
    /// prompt as shown in the example.
    pub fn getDiscoverySummary(self: *Self, allocator: std.mem.Allocator, input: get_discovery_summary.GetDiscoverySummaryInput, options: get_discovery_summary.Options) !get_discovery_summary.GetDiscoverySummaryOutput {
        return get_discovery_summary.execute(self, allocator, input, options);
    }

    /// Retrieves a list of configuration items as specified by the value passed to
    /// the
    /// required parameter `configurationType`. Optional filtering may be applied to
    /// refine
    /// search results.
    pub fn listConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_configurations.ListConfigurationsInput, options: list_configurations.Options) !list_configurations.ListConfigurationsOutput {
        return list_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves a list of servers that are one network hop away from a specified
    /// server.
    pub fn listServerNeighbors(self: *Self, allocator: std.mem.Allocator, input: list_server_neighbors.ListServerNeighborsInput, options: list_server_neighbors.Options) !list_server_neighbors.ListServerNeighborsOutput {
        return list_server_neighbors.execute(self, allocator, input, options);
    }

    /// Takes a list of configurationId as input and starts an asynchronous deletion
    /// task to remove the configurationItems. Returns a unique deletion task
    /// identifier.
    pub fn startBatchDeleteConfigurationTask(self: *Self, allocator: std.mem.Allocator, input: start_batch_delete_configuration_task.StartBatchDeleteConfigurationTaskInput, options: start_batch_delete_configuration_task.Options) !start_batch_delete_configuration_task.StartBatchDeleteConfigurationTaskOutput {
        return start_batch_delete_configuration_task.execute(self, allocator, input, options);
    }

    /// Start the continuous flow of agent's discovered data into Amazon Athena.
    pub fn startContinuousExport(self: *Self, allocator: std.mem.Allocator, input: start_continuous_export.StartContinuousExportInput, options: start_continuous_export.Options) !start_continuous_export.StartContinuousExportOutput {
        return start_continuous_export.execute(self, allocator, input, options);
    }

    /// Instructs the specified agents to start collecting data.
    pub fn startDataCollectionByAgentIds(self: *Self, allocator: std.mem.Allocator, input: start_data_collection_by_agent_ids.StartDataCollectionByAgentIdsInput, options: start_data_collection_by_agent_ids.Options) !start_data_collection_by_agent_ids.StartDataCollectionByAgentIdsOutput {
        return start_data_collection_by_agent_ids.execute(self, allocator, input, options);
    }

    /// Begins the export of a discovered data report to an Amazon S3 bucket managed
    /// by Amazon Web Services.
    ///
    /// Exports might provide an estimate of fees and savings based on certain
    /// information
    /// that you provide. Fee estimates do not include any taxes that might apply.
    /// Your actual fees and savings depend on a variety of factors, including your
    /// actual usage of Amazon Web Services
    /// services, which might vary from the estimates provided in this report.
    ///
    /// If you do not specify `preferences` or `agentIds` in the filter, a
    /// summary of all servers, applications, tags, and performance is generated.
    /// This data is an
    /// aggregation of all server data collected through on-premises tooling, file
    /// import, application
    /// grouping and applying tags.
    ///
    /// If you specify `agentIds` in a filter, the task exports up to 72 hours of
    /// detailed data collected by the identified Application Discovery Agent,
    /// including network,
    /// process, and performance details. A time range for exported agent data may
    /// be set by using
    /// `startTime` and `endTime`. Export of detailed agent data is limited to
    /// five concurrently running exports.
    /// Export of detailed agent data is limited to two exports per day.
    ///
    /// If you enable `ec2RecommendationsPreferences` in `preferences`
    /// , an
    /// Amazon EC2 instance matching the characteristics of each server in
    /// Application Discovery Service is generated.
    /// Changing the attributes of the `ec2RecommendationsPreferences` changes the
    /// criteria of the recommendation.
    pub fn startExportTask(self: *Self, allocator: std.mem.Allocator, input: start_export_task.StartExportTaskInput, options: start_export_task.Options) !start_export_task.StartExportTaskOutput {
        return start_export_task.execute(self, allocator, input, options);
    }

    /// Starts an import task, which allows you to import details of your
    /// on-premises environment
    /// directly into Amazon Web Services Migration Hub without having to use the
    /// Amazon Web Services Application Discovery
    /// Service (Application Discovery Service) tools such as the Amazon Web
    /// Services Application Discovery Service Agentless Collector
    /// or Application Discovery Agent. This gives you the option to
    /// perform migration assessment and planning directly from your imported data,
    /// including the
    /// ability to group your devices as applications and track their migration
    /// status.
    ///
    /// To start an import request, do this:
    ///
    /// * Download the specially formatted comma separated value (CSV) import
    ///   template, which
    /// you can find here:
    /// [https://s3.us-west-2.amazonaws.com/templates-7cffcf56-bd96-4b1c-b45b-a5b42f282e46/import_template.csv](https://s3.us-west-2.amazonaws.com/templates-7cffcf56-bd96-4b1c-b45b-a5b42f282e46/import_template.csv).
    ///
    /// * Fill out the template with your server and application data.
    ///
    /// * Upload your import file to an Amazon S3 bucket, and make a note of it's
    ///   Object URL.
    /// Your import file must be in the CSV format.
    ///
    /// * Use the console or the `StartImportTask` command with the Amazon Web
    ///   Services CLI or one
    /// of the Amazon Web Services SDKs to import the records from your file.
    ///
    /// For more information, including step-by-step procedures, see [Migration Hub
    /// Import](https://docs.aws.amazon.com/application-discovery/latest/userguide/discovery-import.html) in the *Amazon Web Services Application Discovery Service User
    /// Guide*.
    ///
    /// There are limits to the number of import tasks you can create (and delete)
    /// in an Amazon Web Services
    /// account. For more information, see [Amazon Web Services Application
    /// Discovery Service
    /// Limits](https://docs.aws.amazon.com/application-discovery/latest/userguide/ads_service_limits.html) in the *Amazon Web Services Application Discovery Service User
    /// Guide*.
    pub fn startImportTask(self: *Self, allocator: std.mem.Allocator, input: start_import_task.StartImportTaskInput, options: start_import_task.Options) !start_import_task.StartImportTaskOutput {
        return start_import_task.execute(self, allocator, input, options);
    }

    /// Stop the continuous flow of agent's discovered data into Amazon Athena.
    pub fn stopContinuousExport(self: *Self, allocator: std.mem.Allocator, input: stop_continuous_export.StopContinuousExportInput, options: stop_continuous_export.Options) !stop_continuous_export.StopContinuousExportOutput {
        return stop_continuous_export.execute(self, allocator, input, options);
    }

    /// Instructs the specified agents to stop collecting data.
    pub fn stopDataCollectionByAgentIds(self: *Self, allocator: std.mem.Allocator, input: stop_data_collection_by_agent_ids.StopDataCollectionByAgentIdsInput, options: stop_data_collection_by_agent_ids.Options) !stop_data_collection_by_agent_ids.StopDataCollectionByAgentIdsOutput {
        return stop_data_collection_by_agent_ids.execute(self, allocator, input, options);
    }

    /// Updates metadata about an application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    pub fn describeAgentsPaginator(self: *Self, params: describe_agents.DescribeAgentsInput) paginator.DescribeAgentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeContinuousExportsPaginator(self: *Self, params: describe_continuous_exports.DescribeContinuousExportsInput) paginator.DescribeContinuousExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeExportConfigurationsPaginator(self: *Self, params: describe_export_configurations.DescribeExportConfigurationsInput) paginator.DescribeExportConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeExportTasksPaginator(self: *Self, params: describe_export_tasks.DescribeExportTasksInput) paginator.DescribeExportTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImportTasksPaginator(self: *Self, params: describe_import_tasks.DescribeImportTasksInput) paginator.DescribeImportTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTagsPaginator(self: *Self, params: describe_tags.DescribeTagsInput) paginator.DescribeTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listConfigurationsPaginator(self: *Self, params: list_configurations.ListConfigurationsInput) paginator.ListConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
