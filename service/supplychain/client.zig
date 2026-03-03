const aws = @import("aws");
const std = @import("std");

const create_bill_of_materials_import_job = @import("create_bill_of_materials_import_job.zig");
const create_data_integration_flow = @import("create_data_integration_flow.zig");
const create_data_lake_dataset = @import("create_data_lake_dataset.zig");
const create_data_lake_namespace = @import("create_data_lake_namespace.zig");
const create_instance = @import("create_instance.zig");
const delete_data_integration_flow = @import("delete_data_integration_flow.zig");
const delete_data_lake_dataset = @import("delete_data_lake_dataset.zig");
const delete_data_lake_namespace = @import("delete_data_lake_namespace.zig");
const delete_instance = @import("delete_instance.zig");
const get_bill_of_materials_import_job = @import("get_bill_of_materials_import_job.zig");
const get_data_integration_event = @import("get_data_integration_event.zig");
const get_data_integration_flow = @import("get_data_integration_flow.zig");
const get_data_integration_flow_execution = @import("get_data_integration_flow_execution.zig");
const get_data_lake_dataset = @import("get_data_lake_dataset.zig");
const get_data_lake_namespace = @import("get_data_lake_namespace.zig");
const get_instance = @import("get_instance.zig");
const list_data_integration_events = @import("list_data_integration_events.zig");
const list_data_integration_flow_executions = @import("list_data_integration_flow_executions.zig");
const list_data_integration_flows = @import("list_data_integration_flows.zig");
const list_data_lake_datasets = @import("list_data_lake_datasets.zig");
const list_data_lake_namespaces = @import("list_data_lake_namespaces.zig");
const list_instances = @import("list_instances.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const send_data_integration_event = @import("send_data_integration_event.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_data_integration_flow = @import("update_data_integration_flow.zig");
const update_data_lake_dataset = @import("update_data_lake_dataset.zig");
const update_data_lake_namespace = @import("update_data_lake_namespace.zig");
const update_instance = @import("update_instance.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SupplyChain";

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

    /// CreateBillOfMaterialsImportJob creates an import job for the Product Bill Of
    /// Materials (BOM) entity. For information on the product_bom entity, see the
    /// AWS Supply Chain User Guide.
    ///
    /// The CSV file must be located in an Amazon S3 location accessible to AWS
    /// Supply Chain. It is recommended to use the same Amazon S3 bucket created
    /// during your AWS Supply Chain instance creation.
    pub fn createBillOfMaterialsImportJob(self: *Self, allocator: std.mem.Allocator, input: create_bill_of_materials_import_job.CreateBillOfMaterialsImportJobInput, options: create_bill_of_materials_import_job.Options) !create_bill_of_materials_import_job.CreateBillOfMaterialsImportJobOutput {
        return create_bill_of_materials_import_job.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically create a data pipeline to ingest data from
    /// source systems such as Amazon S3 buckets, to a predefined Amazon Web
    /// Services Supply Chain dataset (product, inbound_order) or a temporary
    /// dataset along with the data transformation query provided with the API.
    pub fn createDataIntegrationFlow(self: *Self, allocator: std.mem.Allocator, input: create_data_integration_flow.CreateDataIntegrationFlowInput, options: create_data_integration_flow.Options) !create_data_integration_flow.CreateDataIntegrationFlowOutput {
        return create_data_integration_flow.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically create an Amazon Web Services Supply Chain
    /// data lake dataset. Developers can create the datasets using their
    /// pre-defined or custom schema for a given instance ID, namespace, and dataset
    /// name.
    pub fn createDataLakeDataset(self: *Self, allocator: std.mem.Allocator, input: create_data_lake_dataset.CreateDataLakeDatasetInput, options: create_data_lake_dataset.Options) !create_data_lake_dataset.CreateDataLakeDatasetOutput {
        return create_data_lake_dataset.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically create an Amazon Web Services Supply Chain
    /// data lake namespace. Developers can create the namespaces for a given
    /// instance ID.
    pub fn createDataLakeNamespace(self: *Self, allocator: std.mem.Allocator, input: create_data_lake_namespace.CreateDataLakeNamespaceInput, options: create_data_lake_namespace.Options) !create_data_lake_namespace.CreateDataLakeNamespaceOutput {
        return create_data_lake_namespace.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically create an Amazon Web Services Supply Chain
    /// instance by applying KMS keys and relevant information associated with the
    /// API without using the Amazon Web Services console.
    ///
    /// This is an asynchronous operation. Upon receiving a CreateInstance request,
    /// Amazon Web Services Supply Chain immediately returns the instance resource,
    /// instance ID, and the initializing state while simultaneously creating all
    /// required Amazon Web Services resources for an instance creation. You can use
    /// GetInstance to check the status of the instance. If the instance results in
    /// an unhealthy state, you need to check the error message, delete the current
    /// instance, and recreate a new one based on the mitigation from the error
    /// message.
    pub fn createInstance(self: *Self, allocator: std.mem.Allocator, input: create_instance.CreateInstanceInput, options: create_instance.Options) !create_instance.CreateInstanceOutput {
        return create_instance.execute(self, allocator, input, options);
    }

    /// Enable you to programmatically delete an existing data pipeline for the
    /// provided Amazon Web Services Supply Chain instance and DataIntegrationFlow
    /// name.
    pub fn deleteDataIntegrationFlow(self: *Self, allocator: std.mem.Allocator, input: delete_data_integration_flow.DeleteDataIntegrationFlowInput, options: delete_data_integration_flow.Options) !delete_data_integration_flow.DeleteDataIntegrationFlowOutput {
        return delete_data_integration_flow.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically delete an Amazon Web Services Supply Chain
    /// data lake dataset. Developers can delete the existing datasets for a given
    /// instance ID, namespace, and instance name.
    pub fn deleteDataLakeDataset(self: *Self, allocator: std.mem.Allocator, input: delete_data_lake_dataset.DeleteDataLakeDatasetInput, options: delete_data_lake_dataset.Options) !delete_data_lake_dataset.DeleteDataLakeDatasetOutput {
        return delete_data_lake_dataset.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically delete an Amazon Web Services Supply Chain
    /// data lake namespace and its underling datasets. Developers can delete the
    /// existing namespaces for a given instance ID and namespace name.
    pub fn deleteDataLakeNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_data_lake_namespace.DeleteDataLakeNamespaceInput, options: delete_data_lake_namespace.Options) !delete_data_lake_namespace.DeleteDataLakeNamespaceOutput {
        return delete_data_lake_namespace.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically delete an Amazon Web Services Supply Chain
    /// instance by deleting the KMS keys and relevant information associated with
    /// the API without using the Amazon Web Services console.
    ///
    /// This is an asynchronous operation. Upon receiving a DeleteInstance request,
    /// Amazon Web Services Supply Chain immediately returns a response with the
    /// instance resource, delete state while cleaning up all Amazon Web Services
    /// resources created during the instance creation process. You can use the
    /// GetInstance action to check the instance status.
    pub fn deleteInstance(self: *Self, allocator: std.mem.Allocator, input: delete_instance.DeleteInstanceInput, options: delete_instance.Options) !delete_instance.DeleteInstanceOutput {
        return delete_instance.execute(self, allocator, input, options);
    }

    /// Get status and details of a BillOfMaterialsImportJob.
    pub fn getBillOfMaterialsImportJob(self: *Self, allocator: std.mem.Allocator, input: get_bill_of_materials_import_job.GetBillOfMaterialsImportJobInput, options: get_bill_of_materials_import_job.Options) !get_bill_of_materials_import_job.GetBillOfMaterialsImportJobOutput {
        return get_bill_of_materials_import_job.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view an Amazon Web Services Supply Chain
    /// Data Integration Event. Developers can view the eventType, eventGroupId,
    /// eventTimestamp, datasetTarget, datasetLoadExecution.
    pub fn getDataIntegrationEvent(self: *Self, allocator: std.mem.Allocator, input: get_data_integration_event.GetDataIntegrationEventInput, options: get_data_integration_event.Options) !get_data_integration_event.GetDataIntegrationEventOutput {
        return get_data_integration_event.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view a specific data pipeline for the
    /// provided Amazon Web Services Supply Chain instance and DataIntegrationFlow
    /// name.
    pub fn getDataIntegrationFlow(self: *Self, allocator: std.mem.Allocator, input: get_data_integration_flow.GetDataIntegrationFlowInput, options: get_data_integration_flow.Options) !get_data_integration_flow.GetDataIntegrationFlowOutput {
        return get_data_integration_flow.execute(self, allocator, input, options);
    }

    /// Get the flow execution.
    pub fn getDataIntegrationFlowExecution(self: *Self, allocator: std.mem.Allocator, input: get_data_integration_flow_execution.GetDataIntegrationFlowExecutionInput, options: get_data_integration_flow_execution.Options) !get_data_integration_flow_execution.GetDataIntegrationFlowExecutionOutput {
        return get_data_integration_flow_execution.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view an Amazon Web Services Supply Chain
    /// data lake dataset. Developers can view the data lake dataset information
    /// such as namespace, schema, and so on for a given instance ID, namespace, and
    /// dataset name.
    pub fn getDataLakeDataset(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_dataset.GetDataLakeDatasetInput, options: get_data_lake_dataset.Options) !get_data_lake_dataset.GetDataLakeDatasetOutput {
        return get_data_lake_dataset.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view an Amazon Web Services Supply Chain
    /// data lake namespace. Developers can view the data lake namespace information
    /// such as description for a given instance ID and namespace name.
    pub fn getDataLakeNamespace(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_namespace.GetDataLakeNamespaceInput, options: get_data_lake_namespace.Options) !get_data_lake_namespace.GetDataLakeNamespaceOutput {
        return get_data_lake_namespace.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically retrieve the information related to an
    /// Amazon Web Services Supply Chain instance ID.
    pub fn getInstance(self: *Self, allocator: std.mem.Allocator, input: get_instance.GetInstanceInput, options: get_instance.Options) !get_instance.GetInstanceOutput {
        return get_instance.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically list all data integration events for the
    /// provided Amazon Web Services Supply Chain instance.
    pub fn listDataIntegrationEvents(self: *Self, allocator: std.mem.Allocator, input: list_data_integration_events.ListDataIntegrationEventsInput, options: list_data_integration_events.Options) !list_data_integration_events.ListDataIntegrationEventsOutput {
        return list_data_integration_events.execute(self, allocator, input, options);
    }

    /// List flow executions.
    pub fn listDataIntegrationFlowExecutions(self: *Self, allocator: std.mem.Allocator, input: list_data_integration_flow_executions.ListDataIntegrationFlowExecutionsInput, options: list_data_integration_flow_executions.Options) !list_data_integration_flow_executions.ListDataIntegrationFlowExecutionsOutput {
        return list_data_integration_flow_executions.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically list all data pipelines for the provided
    /// Amazon Web Services Supply Chain instance.
    pub fn listDataIntegrationFlows(self: *Self, allocator: std.mem.Allocator, input: list_data_integration_flows.ListDataIntegrationFlowsInput, options: list_data_integration_flows.Options) !list_data_integration_flows.ListDataIntegrationFlowsOutput {
        return list_data_integration_flows.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view the list of Amazon Web Services Supply
    /// Chain data lake datasets. Developers can view the datasets and the
    /// corresponding information such as namespace, schema, and so on for a given
    /// instance ID and namespace.
    pub fn listDataLakeDatasets(self: *Self, allocator: std.mem.Allocator, input: list_data_lake_datasets.ListDataLakeDatasetsInput, options: list_data_lake_datasets.Options) !list_data_lake_datasets.ListDataLakeDatasetsOutput {
        return list_data_lake_datasets.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically view the list of Amazon Web Services Supply
    /// Chain data lake namespaces. Developers can view the namespaces and the
    /// corresponding information such as description for a given instance ID. Note
    /// that this API only return custom namespaces, instance pre-defined namespaces
    /// are not included.
    pub fn listDataLakeNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_data_lake_namespaces.ListDataLakeNamespacesInput, options: list_data_lake_namespaces.Options) !list_data_lake_namespaces.ListDataLakeNamespacesOutput {
        return list_data_lake_namespaces.execute(self, allocator, input, options);
    }

    /// List all Amazon Web Services Supply Chain instances for a specific account.
    /// Enables you to programmatically list all Amazon Web Services Supply Chain
    /// instances based on their account ID, instance name, and state of the
    /// instance (active or delete).
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: list_instances.Options) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// List all the tags for an Amazon Web ServicesSupply Chain resource. You can
    /// list all the tags added to a resource. By listing the tags, developers can
    /// view the tag level information on a resource and perform actions such as,
    /// deleting a resource associated with a particular tag.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Send the data payload for the event with real-time data for analysis or
    /// monitoring. The real-time data events are stored in an Amazon Web Services
    /// service before being processed and stored in data lake.
    pub fn sendDataIntegrationEvent(self: *Self, allocator: std.mem.Allocator, input: send_data_integration_event.SendDataIntegrationEventInput, options: send_data_integration_event.Options) !send_data_integration_event.SendDataIntegrationEventOutput {
        return send_data_integration_event.execute(self, allocator, input, options);
    }

    /// You can create tags during or after creating a resource such as instance,
    /// data flow, or dataset in AWS Supply chain. During the data ingestion
    /// process, you can add tags such as dev, test, or prod to data flows created
    /// during the data ingestion process in the AWS Supply Chain datasets. You can
    /// use these tags to identify a group of resources or a single resource used by
    /// the developer.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// You can delete tags for an Amazon Web Services Supply chain resource such as
    /// instance, data flow, or dataset in AWS Supply Chain. During the data
    /// ingestion process, you can delete tags such as dev, test, or prod to data
    /// flows created during the data ingestion process in the AWS Supply Chain
    /// datasets.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically update an existing data pipeline to ingest
    /// data from the source systems such as, Amazon S3 buckets, to a predefined
    /// Amazon Web Services Supply Chain dataset (product, inbound_order) or a
    /// temporary dataset along with the data transformation query provided with the
    /// API.
    pub fn updateDataIntegrationFlow(self: *Self, allocator: std.mem.Allocator, input: update_data_integration_flow.UpdateDataIntegrationFlowInput, options: update_data_integration_flow.Options) !update_data_integration_flow.UpdateDataIntegrationFlowOutput {
        return update_data_integration_flow.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically update an Amazon Web Services Supply Chain
    /// data lake dataset. Developers can update the description of a data lake
    /// dataset for a given instance ID, namespace, and dataset name.
    pub fn updateDataLakeDataset(self: *Self, allocator: std.mem.Allocator, input: update_data_lake_dataset.UpdateDataLakeDatasetInput, options: update_data_lake_dataset.Options) !update_data_lake_dataset.UpdateDataLakeDatasetOutput {
        return update_data_lake_dataset.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically update an Amazon Web Services Supply Chain
    /// data lake namespace. Developers can update the description of a data lake
    /// namespace for a given instance ID and namespace name.
    pub fn updateDataLakeNamespace(self: *Self, allocator: std.mem.Allocator, input: update_data_lake_namespace.UpdateDataLakeNamespaceInput, options: update_data_lake_namespace.Options) !update_data_lake_namespace.UpdateDataLakeNamespaceOutput {
        return update_data_lake_namespace.execute(self, allocator, input, options);
    }

    /// Enables you to programmatically update an Amazon Web Services Supply Chain
    /// instance description by providing all the relevant information such as
    /// account ID, instance ID and so on without using the AWS console.
    pub fn updateInstance(self: *Self, allocator: std.mem.Allocator, input: update_instance.UpdateInstanceInput, options: update_instance.Options) !update_instance.UpdateInstanceOutput {
        return update_instance.execute(self, allocator, input, options);
    }

    pub fn listDataIntegrationEventsPaginator(self: *Self, params: list_data_integration_events.ListDataIntegrationEventsInput) paginator.ListDataIntegrationEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataIntegrationFlowExecutionsPaginator(self: *Self, params: list_data_integration_flow_executions.ListDataIntegrationFlowExecutionsInput) paginator.ListDataIntegrationFlowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataIntegrationFlowsPaginator(self: *Self, params: list_data_integration_flows.ListDataIntegrationFlowsInput) paginator.ListDataIntegrationFlowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataLakeDatasetsPaginator(self: *Self, params: list_data_lake_datasets.ListDataLakeDatasetsInput) paginator.ListDataLakeDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataLakeNamespacesPaginator(self: *Self, params: list_data_lake_namespaces.ListDataLakeNamespacesInput) paginator.ListDataLakeNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
