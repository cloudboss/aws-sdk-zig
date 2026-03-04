const aws = @import("aws");
const std = @import("std");

const associate_entity_to_thing = @import("associate_entity_to_thing.zig");
const create_flow_template = @import("create_flow_template.zig");
const create_system_instance = @import("create_system_instance.zig");
const create_system_template = @import("create_system_template.zig");
const delete_flow_template = @import("delete_flow_template.zig");
const delete_namespace = @import("delete_namespace.zig");
const delete_system_instance = @import("delete_system_instance.zig");
const delete_system_template = @import("delete_system_template.zig");
const deploy_system_instance = @import("deploy_system_instance.zig");
const deprecate_flow_template = @import("deprecate_flow_template.zig");
const deprecate_system_template = @import("deprecate_system_template.zig");
const describe_namespace = @import("describe_namespace.zig");
const dissociate_entity_from_thing = @import("dissociate_entity_from_thing.zig");
const get_entities = @import("get_entities.zig");
const get_flow_template = @import("get_flow_template.zig");
const get_flow_template_revisions = @import("get_flow_template_revisions.zig");
const get_namespace_deletion_status = @import("get_namespace_deletion_status.zig");
const get_system_instance = @import("get_system_instance.zig");
const get_system_template = @import("get_system_template.zig");
const get_system_template_revisions = @import("get_system_template_revisions.zig");
const get_upload_status = @import("get_upload_status.zig");
const list_flow_execution_messages = @import("list_flow_execution_messages.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const search_entities = @import("search_entities.zig");
const search_flow_executions = @import("search_flow_executions.zig");
const search_flow_templates = @import("search_flow_templates.zig");
const search_system_instances = @import("search_system_instances.zig");
const search_system_templates = @import("search_system_templates.zig");
const search_things = @import("search_things.zig");
const tag_resource = @import("tag_resource.zig");
const undeploy_system_instance = @import("undeploy_system_instance.zig");
const untag_resource = @import("untag_resource.zig");
const update_flow_template = @import("update_flow_template.zig");
const update_system_template = @import("update_system_template.zig");
const upload_entity_definitions = @import("upload_entity_definitions.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoTThingsGraph";

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

    /// Associates a device with a concrete thing that is in the user's registry.
    ///
    /// A thing can be associated with only one device at a time. If you associate a
    /// thing with a new device id, its previous association will be removed.
    pub fn associateEntityToThing(self: *Self, allocator: std.mem.Allocator, input: associate_entity_to_thing.AssociateEntityToThingInput, options: CallOptions) !associate_entity_to_thing.AssociateEntityToThingOutput {
        return associate_entity_to_thing.execute(self, allocator, input, options);
    }

    /// Creates a workflow template. Workflows can be created only in the user's
    /// namespace. (The public namespace contains only
    /// entities.) The workflow can contain only entities in the specified
    /// namespace. The workflow is validated against the entities in the
    /// latest version of the user's namespace unless another namespace version is
    /// specified in the request.
    pub fn createFlowTemplate(self: *Self, allocator: std.mem.Allocator, input: create_flow_template.CreateFlowTemplateInput, options: CallOptions) !create_flow_template.CreateFlowTemplateOutput {
        return create_flow_template.execute(self, allocator, input, options);
    }

    /// Creates a system instance.
    ///
    /// This action validates the system instance, prepares the deployment-related
    /// resources. For Greengrass deployments, it updates the Greengrass group that
    /// is
    /// specified by the `greengrassGroupName` parameter. It also adds a file to the
    /// S3 bucket specified by the `s3BucketName` parameter. You need to
    /// call `DeploySystemInstance` after running this action.
    ///
    /// For Greengrass deployments, since this action modifies and adds resources to
    /// a Greengrass group and an S3 bucket on the caller's behalf, the calling
    /// identity must have write permissions
    /// to both the specified Greengrass group and S3 bucket. Otherwise, the call
    /// will fail with an authorization error.
    ///
    /// For cloud deployments, this action requires a `flowActionsRoleArn` value.
    /// This is an IAM role
    /// that has permissions to access AWS services, such as AWS Lambda and AWS IoT,
    /// that the flow uses when it executes.
    ///
    /// If the definition document doesn't specify a version of the user's
    /// namespace, the latest version will be used by default.
    pub fn createSystemInstance(self: *Self, allocator: std.mem.Allocator, input: create_system_instance.CreateSystemInstanceInput, options: CallOptions) !create_system_instance.CreateSystemInstanceOutput {
        return create_system_instance.execute(self, allocator, input, options);
    }

    /// Creates a system. The system is validated against the entities in the
    /// latest version of the user's namespace unless another namespace version is
    /// specified in the request.
    pub fn createSystemTemplate(self: *Self, allocator: std.mem.Allocator, input: create_system_template.CreateSystemTemplateInput, options: CallOptions) !create_system_template.CreateSystemTemplateOutput {
        return create_system_template.execute(self, allocator, input, options);
    }

    /// Deletes a workflow. Any new system or deployment that contains this workflow
    /// will fail to update or deploy.
    /// Existing deployments that contain the workflow will continue to run (since
    /// they use a snapshot of the workflow taken at the time of deployment).
    pub fn deleteFlowTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_flow_template.DeleteFlowTemplateInput, options: CallOptions) !delete_flow_template.DeleteFlowTemplateOutput {
        return delete_flow_template.execute(self, allocator, input, options);
    }

    /// Deletes the specified namespace. This action deletes all of the entities in
    /// the namespace. Delete the systems and flows that use entities in the
    /// namespace before performing this action. This action takes no
    /// request parameters.
    pub fn deleteNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_namespace.DeleteNamespaceInput, options: CallOptions) !delete_namespace.DeleteNamespaceOutput {
        return delete_namespace.execute(self, allocator, input, options);
    }

    /// Deletes a system instance.
    /// Only system instances that have never been deployed, or that have been
    /// undeployed can be deleted.
    ///
    /// Users can create a new system instance that has the same ID as a deleted
    /// system instance.
    pub fn deleteSystemInstance(self: *Self, allocator: std.mem.Allocator, input: delete_system_instance.DeleteSystemInstanceInput, options: CallOptions) !delete_system_instance.DeleteSystemInstanceOutput {
        return delete_system_instance.execute(self, allocator, input, options);
    }

    /// Deletes a system. New deployments can't contain the system after its
    /// deletion.
    /// Existing deployments that contain the system will continue to work because
    /// they use a snapshot of the system that is taken when it is deployed.
    pub fn deleteSystemTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_system_template.DeleteSystemTemplateInput, options: CallOptions) !delete_system_template.DeleteSystemTemplateOutput {
        return delete_system_template.execute(self, allocator, input, options);
    }

    /// **Greengrass and Cloud Deployments**
    ///
    /// Deploys the system instance to the target specified in
    /// `CreateSystemInstance`.
    ///
    /// **Greengrass Deployments**
    ///
    /// If the system or any workflows and entities have been updated before this
    /// action is called, then the deployment will create a new Amazon Simple
    /// Storage Service
    /// resource file and then deploy it.
    ///
    /// Since this action creates a Greengrass deployment on the caller's behalf,
    /// the calling identity must have write permissions
    /// to the specified Greengrass group. Otherwise, the call will fail with an
    /// authorization error.
    ///
    /// For information about the artifacts that get added to your Greengrass core
    /// device when you use this API, see [AWS IoT Things Graph and AWS IoT
    /// Greengrass](https://docs.aws.amazon.com/thingsgraph/latest/ug/iot-tg-greengrass.html).
    pub fn deploySystemInstance(self: *Self, allocator: std.mem.Allocator, input: deploy_system_instance.DeploySystemInstanceInput, options: CallOptions) !deploy_system_instance.DeploySystemInstanceOutput {
        return deploy_system_instance.execute(self, allocator, input, options);
    }

    /// Deprecates the specified workflow. This action marks the workflow for
    /// deletion. Deprecated flows can't be deployed, but existing deployments will
    /// continue to run.
    pub fn deprecateFlowTemplate(self: *Self, allocator: std.mem.Allocator, input: deprecate_flow_template.DeprecateFlowTemplateInput, options: CallOptions) !deprecate_flow_template.DeprecateFlowTemplateOutput {
        return deprecate_flow_template.execute(self, allocator, input, options);
    }

    /// Deprecates the specified system.
    pub fn deprecateSystemTemplate(self: *Self, allocator: std.mem.Allocator, input: deprecate_system_template.DeprecateSystemTemplateInput, options: CallOptions) !deprecate_system_template.DeprecateSystemTemplateOutput {
        return deprecate_system_template.execute(self, allocator, input, options);
    }

    /// Gets the latest version of the user's namespace and the public version that
    /// it is tracking.
    pub fn describeNamespace(self: *Self, allocator: std.mem.Allocator, input: describe_namespace.DescribeNamespaceInput, options: CallOptions) !describe_namespace.DescribeNamespaceOutput {
        return describe_namespace.execute(self, allocator, input, options);
    }

    /// Dissociates a device entity from a concrete thing. The action takes only the
    /// type of the entity that you need to dissociate because only
    /// one entity of a particular type can be associated with a thing.
    pub fn dissociateEntityFromThing(self: *Self, allocator: std.mem.Allocator, input: dissociate_entity_from_thing.DissociateEntityFromThingInput, options: CallOptions) !dissociate_entity_from_thing.DissociateEntityFromThingOutput {
        return dissociate_entity_from_thing.execute(self, allocator, input, options);
    }

    /// Gets definitions of the specified entities. Uses the latest version of the
    /// user's namespace by default. This API returns the
    /// following TDM entities.
    ///
    /// * Properties
    ///
    /// * States
    ///
    /// * Events
    ///
    /// * Actions
    ///
    /// * Capabilities
    ///
    /// * Mappings
    ///
    /// * Devices
    ///
    /// * Device Models
    ///
    /// * Services
    ///
    /// This action doesn't return definitions for systems, flows, and deployments.
    pub fn getEntities(self: *Self, allocator: std.mem.Allocator, input: get_entities.GetEntitiesInput, options: CallOptions) !get_entities.GetEntitiesOutput {
        return get_entities.execute(self, allocator, input, options);
    }

    /// Gets the latest version of the `DefinitionDocument` and
    /// `FlowTemplateSummary` for the specified workflow.
    pub fn getFlowTemplate(self: *Self, allocator: std.mem.Allocator, input: get_flow_template.GetFlowTemplateInput, options: CallOptions) !get_flow_template.GetFlowTemplateOutput {
        return get_flow_template.execute(self, allocator, input, options);
    }

    /// Gets revisions of the specified workflow. Only the last 100 revisions are
    /// stored. If the workflow has been deprecated,
    /// this action will return revisions that occurred before the deprecation. This
    /// action won't work for workflows that have been deleted.
    pub fn getFlowTemplateRevisions(self: *Self, allocator: std.mem.Allocator, input: get_flow_template_revisions.GetFlowTemplateRevisionsInput, options: CallOptions) !get_flow_template_revisions.GetFlowTemplateRevisionsOutput {
        return get_flow_template_revisions.execute(self, allocator, input, options);
    }

    /// Gets the status of a namespace deletion task.
    pub fn getNamespaceDeletionStatus(self: *Self, allocator: std.mem.Allocator, input: get_namespace_deletion_status.GetNamespaceDeletionStatusInput, options: CallOptions) !get_namespace_deletion_status.GetNamespaceDeletionStatusOutput {
        return get_namespace_deletion_status.execute(self, allocator, input, options);
    }

    /// Gets a system instance.
    pub fn getSystemInstance(self: *Self, allocator: std.mem.Allocator, input: get_system_instance.GetSystemInstanceInput, options: CallOptions) !get_system_instance.GetSystemInstanceOutput {
        return get_system_instance.execute(self, allocator, input, options);
    }

    /// Gets a system.
    pub fn getSystemTemplate(self: *Self, allocator: std.mem.Allocator, input: get_system_template.GetSystemTemplateInput, options: CallOptions) !get_system_template.GetSystemTemplateOutput {
        return get_system_template.execute(self, allocator, input, options);
    }

    /// Gets revisions made to the specified system template. Only the previous 100
    /// revisions are stored. If the system has been deprecated, this action will
    /// return
    /// the revisions that occurred before its deprecation. This action won't work
    /// with systems that have been deleted.
    pub fn getSystemTemplateRevisions(self: *Self, allocator: std.mem.Allocator, input: get_system_template_revisions.GetSystemTemplateRevisionsInput, options: CallOptions) !get_system_template_revisions.GetSystemTemplateRevisionsOutput {
        return get_system_template_revisions.execute(self, allocator, input, options);
    }

    /// Gets the status of the specified upload.
    pub fn getUploadStatus(self: *Self, allocator: std.mem.Allocator, input: get_upload_status.GetUploadStatusInput, options: CallOptions) !get_upload_status.GetUploadStatusOutput {
        return get_upload_status.execute(self, allocator, input, options);
    }

    /// Returns a list of objects that contain information about events in a flow
    /// execution.
    pub fn listFlowExecutionMessages(self: *Self, allocator: std.mem.Allocator, input: list_flow_execution_messages.ListFlowExecutionMessagesInput, options: CallOptions) !list_flow_execution_messages.ListFlowExecutionMessagesOutput {
        return list_flow_execution_messages.execute(self, allocator, input, options);
    }

    /// Lists all tags on an AWS IoT Things Graph resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Searches for entities of the specified type. You can search for entities in
    /// your namespace and the public namespace that you're tracking.
    pub fn searchEntities(self: *Self, allocator: std.mem.Allocator, input: search_entities.SearchEntitiesInput, options: CallOptions) !search_entities.SearchEntitiesOutput {
        return search_entities.execute(self, allocator, input, options);
    }

    /// Searches for AWS IoT Things Graph workflow execution instances.
    pub fn searchFlowExecutions(self: *Self, allocator: std.mem.Allocator, input: search_flow_executions.SearchFlowExecutionsInput, options: CallOptions) !search_flow_executions.SearchFlowExecutionsOutput {
        return search_flow_executions.execute(self, allocator, input, options);
    }

    /// Searches for summary information about workflows.
    pub fn searchFlowTemplates(self: *Self, allocator: std.mem.Allocator, input: search_flow_templates.SearchFlowTemplatesInput, options: CallOptions) !search_flow_templates.SearchFlowTemplatesOutput {
        return search_flow_templates.execute(self, allocator, input, options);
    }

    /// Searches for system instances in the user's account.
    pub fn searchSystemInstances(self: *Self, allocator: std.mem.Allocator, input: search_system_instances.SearchSystemInstancesInput, options: CallOptions) !search_system_instances.SearchSystemInstancesOutput {
        return search_system_instances.execute(self, allocator, input, options);
    }

    /// Searches for summary information about systems in the user's account. You
    /// can filter by the ID of a workflow to return only systems that use the
    /// specified workflow.
    pub fn searchSystemTemplates(self: *Self, allocator: std.mem.Allocator, input: search_system_templates.SearchSystemTemplatesInput, options: CallOptions) !search_system_templates.SearchSystemTemplatesOutput {
        return search_system_templates.execute(self, allocator, input, options);
    }

    /// Searches for things associated with the specified entity. You can search by
    /// both device and device model.
    ///
    /// For example, if two different devices, camera1 and camera2, implement the
    /// camera device model, the user can associate thing1 to camera1 and thing2 to
    /// camera2.
    /// `SearchThings(camera2)` will return only thing2, but `SearchThings(camera)`
    /// will return both thing1 and thing2.
    ///
    /// This action searches for exact matches and doesn't perform partial text
    /// matching.
    pub fn searchThings(self: *Self, allocator: std.mem.Allocator, input: search_things.SearchThingsInput, options: CallOptions) !search_things.SearchThingsOutput {
        return search_things.execute(self, allocator, input, options);
    }

    /// Creates a tag for the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a system instance from its target (Cloud or Greengrass).
    pub fn undeploySystemInstance(self: *Self, allocator: std.mem.Allocator, input: undeploy_system_instance.UndeploySystemInstanceInput, options: CallOptions) !undeploy_system_instance.UndeploySystemInstanceOutput {
        return undeploy_system_instance.execute(self, allocator, input, options);
    }

    /// Removes a tag from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified workflow. All deployed systems and system instances
    /// that use the workflow will see the changes in the flow when it is
    /// redeployed. If you don't want this
    /// behavior, copy the workflow (creating a new workflow with a different ID),
    /// and update the copy. The workflow can contain only entities in the specified
    /// namespace.
    pub fn updateFlowTemplate(self: *Self, allocator: std.mem.Allocator, input: update_flow_template.UpdateFlowTemplateInput, options: CallOptions) !update_flow_template.UpdateFlowTemplateOutput {
        return update_flow_template.execute(self, allocator, input, options);
    }

    /// Updates the specified system. You don't need to run this action after
    /// updating a workflow. Any deployment that uses the system will see the
    /// changes in the system when it is redeployed.
    pub fn updateSystemTemplate(self: *Self, allocator: std.mem.Allocator, input: update_system_template.UpdateSystemTemplateInput, options: CallOptions) !update_system_template.UpdateSystemTemplateOutput {
        return update_system_template.execute(self, allocator, input, options);
    }

    /// Asynchronously uploads one or more entity definitions to the user's
    /// namespace. The `document` parameter is required if
    /// `syncWithPublicNamespace` and `deleteExistingEntites` are false. If the
    /// `syncWithPublicNamespace` parameter is set to
    /// `true`, the user's namespace will synchronize with the latest version of the
    /// public namespace. If `deprecateExistingEntities` is set to true,
    /// all entities in the latest version will be deleted before the new
    /// `DefinitionDocument` is uploaded.
    ///
    /// When a user uploads entity definitions for the first time, the service
    /// creates a new namespace for the user. The new namespace tracks the public
    /// namespace. Currently users
    /// can have only one namespace. The namespace version increments whenever a
    /// user uploads entity definitions that are backwards-incompatible and whenever
    /// a user sets the
    /// `syncWithPublicNamespace` parameter or the `deprecateExistingEntities`
    /// parameter to `true`.
    ///
    /// The IDs for all of the entities should be in URN format. Each entity must be
    /// in the user's namespace. Users can't create entities in the public
    /// namespace, but entity definitions can refer to entities in the public
    /// namespace.
    ///
    /// Valid entities are `Device`, `DeviceModel`, `Service`, `Capability`,
    /// `State`, `Action`, `Event`, `Property`,
    /// `Mapping`, `Enum`.
    pub fn uploadEntityDefinitions(self: *Self, allocator: std.mem.Allocator, input: upload_entity_definitions.UploadEntityDefinitionsInput, options: CallOptions) !upload_entity_definitions.UploadEntityDefinitionsOutput {
        return upload_entity_definitions.execute(self, allocator, input, options);
    }

    pub fn getFlowTemplateRevisionsPaginator(self: *Self, params: get_flow_template_revisions.GetFlowTemplateRevisionsInput) paginator.GetFlowTemplateRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getSystemTemplateRevisionsPaginator(self: *Self, params: get_system_template_revisions.GetSystemTemplateRevisionsInput) paginator.GetSystemTemplateRevisionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlowExecutionMessagesPaginator(self: *Self, params: list_flow_execution_messages.ListFlowExecutionMessagesInput) paginator.ListFlowExecutionMessagesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchEntitiesPaginator(self: *Self, params: search_entities.SearchEntitiesInput) paginator.SearchEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFlowExecutionsPaginator(self: *Self, params: search_flow_executions.SearchFlowExecutionsInput) paginator.SearchFlowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchFlowTemplatesPaginator(self: *Self, params: search_flow_templates.SearchFlowTemplatesInput) paginator.SearchFlowTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchSystemInstancesPaginator(self: *Self, params: search_system_instances.SearchSystemInstancesInput) paginator.SearchSystemInstancesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchSystemTemplatesPaginator(self: *Self, params: search_system_templates.SearchSystemTemplatesInput) paginator.SearchSystemTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchThingsPaginator(self: *Self, params: search_things.SearchThingsInput) paginator.SearchThingsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
