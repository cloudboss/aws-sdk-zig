const aws = @import("aws");
const std = @import("std");

const batch_put_property_values = @import("batch_put_property_values.zig");
const cancel_metadata_transfer_job = @import("cancel_metadata_transfer_job.zig");
const create_component_type = @import("create_component_type.zig");
const create_entity = @import("create_entity.zig");
const create_metadata_transfer_job = @import("create_metadata_transfer_job.zig");
const create_scene = @import("create_scene.zig");
const create_sync_job = @import("create_sync_job.zig");
const create_workspace = @import("create_workspace.zig");
const delete_component_type = @import("delete_component_type.zig");
const delete_entity = @import("delete_entity.zig");
const delete_scene = @import("delete_scene.zig");
const delete_sync_job = @import("delete_sync_job.zig");
const delete_workspace = @import("delete_workspace.zig");
const execute_query = @import("execute_query.zig");
const get_component_type = @import("get_component_type.zig");
const get_entity = @import("get_entity.zig");
const get_metadata_transfer_job = @import("get_metadata_transfer_job.zig");
const get_pricing_plan = @import("get_pricing_plan.zig");
const get_property_value = @import("get_property_value.zig");
const get_property_value_history = @import("get_property_value_history.zig");
const get_scene = @import("get_scene.zig");
const get_sync_job = @import("get_sync_job.zig");
const get_workspace = @import("get_workspace.zig");
const list_component_types = @import("list_component_types.zig");
const list_components = @import("list_components.zig");
const list_entities = @import("list_entities.zig");
const list_metadata_transfer_jobs = @import("list_metadata_transfer_jobs.zig");
const list_properties = @import("list_properties.zig");
const list_scenes = @import("list_scenes.zig");
const list_sync_jobs = @import("list_sync_jobs.zig");
const list_sync_resources = @import("list_sync_resources.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_workspaces = @import("list_workspaces.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_component_type = @import("update_component_type.zig");
const update_entity = @import("update_entity.zig");
const update_pricing_plan = @import("update_pricing_plan.zig");
const update_scene = @import("update_scene.zig");
const update_workspace = @import("update_workspace.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoTTwinMaker";

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

    /// Sets values for multiple time series properties.
    pub fn batchPutPropertyValues(self: *Self, allocator: std.mem.Allocator, input: batch_put_property_values.BatchPutPropertyValuesInput, options: batch_put_property_values.Options) !batch_put_property_values.BatchPutPropertyValuesOutput {
        return batch_put_property_values.execute(self, allocator, input, options);
    }

    /// Cancels the metadata transfer job.
    pub fn cancelMetadataTransferJob(self: *Self, allocator: std.mem.Allocator, input: cancel_metadata_transfer_job.CancelMetadataTransferJobInput, options: cancel_metadata_transfer_job.Options) !cancel_metadata_transfer_job.CancelMetadataTransferJobOutput {
        return cancel_metadata_transfer_job.execute(self, allocator, input, options);
    }

    /// Creates a component type.
    pub fn createComponentType(self: *Self, allocator: std.mem.Allocator, input: create_component_type.CreateComponentTypeInput, options: create_component_type.Options) !create_component_type.CreateComponentTypeOutput {
        return create_component_type.execute(self, allocator, input, options);
    }

    /// Creates an entity.
    pub fn createEntity(self: *Self, allocator: std.mem.Allocator, input: create_entity.CreateEntityInput, options: create_entity.Options) !create_entity.CreateEntityOutput {
        return create_entity.execute(self, allocator, input, options);
    }

    /// Creates a new metadata transfer job.
    pub fn createMetadataTransferJob(self: *Self, allocator: std.mem.Allocator, input: create_metadata_transfer_job.CreateMetadataTransferJobInput, options: create_metadata_transfer_job.Options) !create_metadata_transfer_job.CreateMetadataTransferJobOutput {
        return create_metadata_transfer_job.execute(self, allocator, input, options);
    }

    /// Creates a scene.
    pub fn createScene(self: *Self, allocator: std.mem.Allocator, input: create_scene.CreateSceneInput, options: create_scene.Options) !create_scene.CreateSceneOutput {
        return create_scene.execute(self, allocator, input, options);
    }

    /// This action creates a SyncJob.
    pub fn createSyncJob(self: *Self, allocator: std.mem.Allocator, input: create_sync_job.CreateSyncJobInput, options: create_sync_job.Options) !create_sync_job.CreateSyncJobOutput {
        return create_sync_job.execute(self, allocator, input, options);
    }

    /// Creates a workplace.
    pub fn createWorkspace(self: *Self, allocator: std.mem.Allocator, input: create_workspace.CreateWorkspaceInput, options: create_workspace.Options) !create_workspace.CreateWorkspaceOutput {
        return create_workspace.execute(self, allocator, input, options);
    }

    /// Deletes a component type.
    pub fn deleteComponentType(self: *Self, allocator: std.mem.Allocator, input: delete_component_type.DeleteComponentTypeInput, options: delete_component_type.Options) !delete_component_type.DeleteComponentTypeOutput {
        return delete_component_type.execute(self, allocator, input, options);
    }

    /// Deletes an entity.
    pub fn deleteEntity(self: *Self, allocator: std.mem.Allocator, input: delete_entity.DeleteEntityInput, options: delete_entity.Options) !delete_entity.DeleteEntityOutput {
        return delete_entity.execute(self, allocator, input, options);
    }

    /// Deletes a scene.
    pub fn deleteScene(self: *Self, allocator: std.mem.Allocator, input: delete_scene.DeleteSceneInput, options: delete_scene.Options) !delete_scene.DeleteSceneOutput {
        return delete_scene.execute(self, allocator, input, options);
    }

    /// Delete the SyncJob.
    pub fn deleteSyncJob(self: *Self, allocator: std.mem.Allocator, input: delete_sync_job.DeleteSyncJobInput, options: delete_sync_job.Options) !delete_sync_job.DeleteSyncJobOutput {
        return delete_sync_job.execute(self, allocator, input, options);
    }

    /// Deletes a workspace.
    pub fn deleteWorkspace(self: *Self, allocator: std.mem.Allocator, input: delete_workspace.DeleteWorkspaceInput, options: delete_workspace.Options) !delete_workspace.DeleteWorkspaceOutput {
        return delete_workspace.execute(self, allocator, input, options);
    }

    /// Run queries to access information from your knowledge graph of entities
    /// within
    /// individual workspaces.
    ///
    /// The ExecuteQuery action only works with [Amazon Web Services Java
    /// SDK2](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/home.html).
    /// ExecuteQuery will not work with any Amazon Web Services Java SDK version <
    /// 2.x.
    pub fn executeQuery(self: *Self, allocator: std.mem.Allocator, input: execute_query.ExecuteQueryInput, options: execute_query.Options) !execute_query.ExecuteQueryOutput {
        return execute_query.execute(self, allocator, input, options);
    }

    /// Retrieves information about a component type.
    pub fn getComponentType(self: *Self, allocator: std.mem.Allocator, input: get_component_type.GetComponentTypeInput, options: get_component_type.Options) !get_component_type.GetComponentTypeOutput {
        return get_component_type.execute(self, allocator, input, options);
    }

    /// Retrieves information about an entity.
    pub fn getEntity(self: *Self, allocator: std.mem.Allocator, input: get_entity.GetEntityInput, options: get_entity.Options) !get_entity.GetEntityOutput {
        return get_entity.execute(self, allocator, input, options);
    }

    /// Gets a nmetadata transfer job.
    pub fn getMetadataTransferJob(self: *Self, allocator: std.mem.Allocator, input: get_metadata_transfer_job.GetMetadataTransferJobInput, options: get_metadata_transfer_job.Options) !get_metadata_transfer_job.GetMetadataTransferJobOutput {
        return get_metadata_transfer_job.execute(self, allocator, input, options);
    }

    /// Gets the pricing plan.
    pub fn getPricingPlan(self: *Self, allocator: std.mem.Allocator, input: get_pricing_plan.GetPricingPlanInput, options: get_pricing_plan.Options) !get_pricing_plan.GetPricingPlanOutput {
        return get_pricing_plan.execute(self, allocator, input, options);
    }

    /// Gets the property values for a component, component type, entity, or
    /// workspace.
    ///
    /// You must specify a value for either `componentName`,
    /// `componentTypeId`, `entityId`, or `workspaceId`.
    pub fn getPropertyValue(self: *Self, allocator: std.mem.Allocator, input: get_property_value.GetPropertyValueInput, options: get_property_value.Options) !get_property_value.GetPropertyValueOutput {
        return get_property_value.execute(self, allocator, input, options);
    }

    /// Retrieves information about the history of a time series property value for
    /// a component,
    /// component type, entity, or workspace.
    ///
    /// You must specify a value for `workspaceId`. For entity-specific queries,
    /// specify values for `componentName` and `entityId`. For cross-entity
    /// quries, specify a value for `componentTypeId`.
    pub fn getPropertyValueHistory(self: *Self, allocator: std.mem.Allocator, input: get_property_value_history.GetPropertyValueHistoryInput, options: get_property_value_history.Options) !get_property_value_history.GetPropertyValueHistoryOutput {
        return get_property_value_history.execute(self, allocator, input, options);
    }

    /// Retrieves information about a scene.
    pub fn getScene(self: *Self, allocator: std.mem.Allocator, input: get_scene.GetSceneInput, options: get_scene.Options) !get_scene.GetSceneOutput {
        return get_scene.execute(self, allocator, input, options);
    }

    /// Gets the SyncJob.
    pub fn getSyncJob(self: *Self, allocator: std.mem.Allocator, input: get_sync_job.GetSyncJobInput, options: get_sync_job.Options) !get_sync_job.GetSyncJobOutput {
        return get_sync_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about a workspace.
    pub fn getWorkspace(self: *Self, allocator: std.mem.Allocator, input: get_workspace.GetWorkspaceInput, options: get_workspace.Options) !get_workspace.GetWorkspaceOutput {
        return get_workspace.execute(self, allocator, input, options);
    }

    /// Lists all component types in a workspace.
    pub fn listComponentTypes(self: *Self, allocator: std.mem.Allocator, input: list_component_types.ListComponentTypesInput, options: list_component_types.Options) !list_component_types.ListComponentTypesOutput {
        return list_component_types.execute(self, allocator, input, options);
    }

    /// This API lists the components of an entity.
    pub fn listComponents(self: *Self, allocator: std.mem.Allocator, input: list_components.ListComponentsInput, options: list_components.Options) !list_components.ListComponentsOutput {
        return list_components.execute(self, allocator, input, options);
    }

    /// Lists all entities in a workspace.
    pub fn listEntities(self: *Self, allocator: std.mem.Allocator, input: list_entities.ListEntitiesInput, options: list_entities.Options) !list_entities.ListEntitiesOutput {
        return list_entities.execute(self, allocator, input, options);
    }

    /// Lists the metadata transfer jobs.
    pub fn listMetadataTransferJobs(self: *Self, allocator: std.mem.Allocator, input: list_metadata_transfer_jobs.ListMetadataTransferJobsInput, options: list_metadata_transfer_jobs.Options) !list_metadata_transfer_jobs.ListMetadataTransferJobsOutput {
        return list_metadata_transfer_jobs.execute(self, allocator, input, options);
    }

    /// This API lists the properties of a component.
    pub fn listProperties(self: *Self, allocator: std.mem.Allocator, input: list_properties.ListPropertiesInput, options: list_properties.Options) !list_properties.ListPropertiesOutput {
        return list_properties.execute(self, allocator, input, options);
    }

    /// Lists all scenes in a workspace.
    pub fn listScenes(self: *Self, allocator: std.mem.Allocator, input: list_scenes.ListScenesInput, options: list_scenes.Options) !list_scenes.ListScenesOutput {
        return list_scenes.execute(self, allocator, input, options);
    }

    /// List all SyncJobs.
    pub fn listSyncJobs(self: *Self, allocator: std.mem.Allocator, input: list_sync_jobs.ListSyncJobsInput, options: list_sync_jobs.Options) !list_sync_jobs.ListSyncJobsOutput {
        return list_sync_jobs.execute(self, allocator, input, options);
    }

    /// Lists the sync resources.
    pub fn listSyncResources(self: *Self, allocator: std.mem.Allocator, input: list_sync_resources.ListSyncResourcesInput, options: list_sync_resources.Options) !list_sync_resources.ListSyncResourcesOutput {
        return list_sync_resources.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Retrieves information about workspaces in the current account.
    pub fn listWorkspaces(self: *Self, allocator: std.mem.Allocator, input: list_workspaces.ListWorkspacesInput, options: list_workspaces.Options) !list_workspaces.ListWorkspacesOutput {
        return list_workspaces.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates information in a component type.
    pub fn updateComponentType(self: *Self, allocator: std.mem.Allocator, input: update_component_type.UpdateComponentTypeInput, options: update_component_type.Options) !update_component_type.UpdateComponentTypeOutput {
        return update_component_type.execute(self, allocator, input, options);
    }

    /// Updates an entity.
    pub fn updateEntity(self: *Self, allocator: std.mem.Allocator, input: update_entity.UpdateEntityInput, options: update_entity.Options) !update_entity.UpdateEntityOutput {
        return update_entity.execute(self, allocator, input, options);
    }

    /// Update the pricing plan.
    pub fn updatePricingPlan(self: *Self, allocator: std.mem.Allocator, input: update_pricing_plan.UpdatePricingPlanInput, options: update_pricing_plan.Options) !update_pricing_plan.UpdatePricingPlanOutput {
        return update_pricing_plan.execute(self, allocator, input, options);
    }

    /// Updates a scene.
    pub fn updateScene(self: *Self, allocator: std.mem.Allocator, input: update_scene.UpdateSceneInput, options: update_scene.Options) !update_scene.UpdateSceneOutput {
        return update_scene.execute(self, allocator, input, options);
    }

    /// Updates a workspace.
    pub fn updateWorkspace(self: *Self, allocator: std.mem.Allocator, input: update_workspace.UpdateWorkspaceInput, options: update_workspace.Options) !update_workspace.UpdateWorkspaceOutput {
        return update_workspace.execute(self, allocator, input, options);
    }

    pub fn executeQueryPaginator(self: *Self, params: execute_query.ExecuteQueryInput) paginator.ExecuteQueryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getPropertyValuePaginator(self: *Self, params: get_property_value.GetPropertyValueInput) paginator.GetPropertyValuePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getPropertyValueHistoryPaginator(self: *Self, params: get_property_value_history.GetPropertyValueHistoryInput) paginator.GetPropertyValueHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentTypesPaginator(self: *Self, params: list_component_types.ListComponentTypesInput) paginator.ListComponentTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComponentsPaginator(self: *Self, params: list_components.ListComponentsInput) paginator.ListComponentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitiesPaginator(self: *Self, params: list_entities.ListEntitiesInput) paginator.ListEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMetadataTransferJobsPaginator(self: *Self, params: list_metadata_transfer_jobs.ListMetadataTransferJobsInput) paginator.ListMetadataTransferJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPropertiesPaginator(self: *Self, params: list_properties.ListPropertiesInput) paginator.ListPropertiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScenesPaginator(self: *Self, params: list_scenes.ListScenesInput) paginator.ListScenesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSyncJobsPaginator(self: *Self, params: list_sync_jobs.ListSyncJobsInput) paginator.ListSyncJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSyncResourcesPaginator(self: *Self, params: list_sync_resources.ListSyncResourcesInput) paginator.ListSyncResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkspacesPaginator(self: *Self, params: list_workspaces.ListWorkspacesInput) paginator.ListWorkspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
