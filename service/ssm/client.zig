const aws = @import("aws");
const std = @import("std");


const add_tags_to_resource = @import("add_tags_to_resource.zig");
const associate_ops_item_related_item = @import("associate_ops_item_related_item.zig");
const cancel_command = @import("cancel_command.zig");
const cancel_maintenance_window_execution = @import("cancel_maintenance_window_execution.zig");
const create_activation = @import("create_activation.zig");
const create_association = @import("create_association.zig");
const create_association_batch = @import("create_association_batch.zig");
const create_document = @import("create_document.zig");
const create_maintenance_window = @import("create_maintenance_window.zig");
const create_ops_item = @import("create_ops_item.zig");
const create_ops_metadata = @import("create_ops_metadata.zig");
const create_patch_baseline = @import("create_patch_baseline.zig");
const create_resource_data_sync = @import("create_resource_data_sync.zig");
const delete_activation = @import("delete_activation.zig");
const delete_association = @import("delete_association.zig");
const delete_document = @import("delete_document.zig");
const delete_inventory = @import("delete_inventory.zig");
const delete_maintenance_window = @import("delete_maintenance_window.zig");
const delete_ops_item = @import("delete_ops_item.zig");
const delete_ops_metadata = @import("delete_ops_metadata.zig");
const delete_parameter = @import("delete_parameter.zig");
const delete_parameters = @import("delete_parameters.zig");
const delete_patch_baseline = @import("delete_patch_baseline.zig");
const delete_resource_data_sync = @import("delete_resource_data_sync.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const deregister_managed_instance = @import("deregister_managed_instance.zig");
const deregister_patch_baseline_for_patch_group = @import("deregister_patch_baseline_for_patch_group.zig");
const deregister_target_from_maintenance_window = @import("deregister_target_from_maintenance_window.zig");
const deregister_task_from_maintenance_window = @import("deregister_task_from_maintenance_window.zig");
const describe_activations = @import("describe_activations.zig");
const describe_association = @import("describe_association.zig");
const describe_association_execution_targets = @import("describe_association_execution_targets.zig");
const describe_association_executions = @import("describe_association_executions.zig");
const describe_automation_executions = @import("describe_automation_executions.zig");
const describe_automation_step_executions = @import("describe_automation_step_executions.zig");
const describe_available_patches = @import("describe_available_patches.zig");
const describe_document = @import("describe_document.zig");
const describe_document_permission = @import("describe_document_permission.zig");
const describe_effective_instance_associations = @import("describe_effective_instance_associations.zig");
const describe_effective_patches_for_patch_baseline = @import("describe_effective_patches_for_patch_baseline.zig");
const describe_instance_associations_status = @import("describe_instance_associations_status.zig");
const describe_instance_information = @import("describe_instance_information.zig");
const describe_instance_patch_states = @import("describe_instance_patch_states.zig");
const describe_instance_patch_states_for_patch_group = @import("describe_instance_patch_states_for_patch_group.zig");
const describe_instance_patches = @import("describe_instance_patches.zig");
const describe_instance_properties = @import("describe_instance_properties.zig");
const describe_inventory_deletions = @import("describe_inventory_deletions.zig");
const describe_maintenance_window_execution_task_invocations = @import("describe_maintenance_window_execution_task_invocations.zig");
const describe_maintenance_window_execution_tasks = @import("describe_maintenance_window_execution_tasks.zig");
const describe_maintenance_window_executions = @import("describe_maintenance_window_executions.zig");
const describe_maintenance_window_schedule = @import("describe_maintenance_window_schedule.zig");
const describe_maintenance_window_targets = @import("describe_maintenance_window_targets.zig");
const describe_maintenance_window_tasks = @import("describe_maintenance_window_tasks.zig");
const describe_maintenance_windows = @import("describe_maintenance_windows.zig");
const describe_maintenance_windows_for_target = @import("describe_maintenance_windows_for_target.zig");
const describe_ops_items = @import("describe_ops_items.zig");
const describe_parameters = @import("describe_parameters.zig");
const describe_patch_baselines = @import("describe_patch_baselines.zig");
const describe_patch_group_state = @import("describe_patch_group_state.zig");
const describe_patch_groups = @import("describe_patch_groups.zig");
const describe_patch_properties = @import("describe_patch_properties.zig");
const describe_sessions = @import("describe_sessions.zig");
const disassociate_ops_item_related_item = @import("disassociate_ops_item_related_item.zig");
const get_access_token = @import("get_access_token.zig");
const get_automation_execution = @import("get_automation_execution.zig");
const get_calendar_state = @import("get_calendar_state.zig");
const get_command_invocation = @import("get_command_invocation.zig");
const get_connection_status = @import("get_connection_status.zig");
const get_default_patch_baseline = @import("get_default_patch_baseline.zig");
const get_deployable_patch_snapshot_for_instance = @import("get_deployable_patch_snapshot_for_instance.zig");
const get_document = @import("get_document.zig");
const get_execution_preview = @import("get_execution_preview.zig");
const get_inventory = @import("get_inventory.zig");
const get_inventory_schema = @import("get_inventory_schema.zig");
const get_maintenance_window = @import("get_maintenance_window.zig");
const get_maintenance_window_execution = @import("get_maintenance_window_execution.zig");
const get_maintenance_window_execution_task = @import("get_maintenance_window_execution_task.zig");
const get_maintenance_window_execution_task_invocation = @import("get_maintenance_window_execution_task_invocation.zig");
const get_maintenance_window_task = @import("get_maintenance_window_task.zig");
const get_ops_item = @import("get_ops_item.zig");
const get_ops_metadata = @import("get_ops_metadata.zig");
const get_ops_summary = @import("get_ops_summary.zig");
const get_parameter = @import("get_parameter.zig");
const get_parameter_history = @import("get_parameter_history.zig");
const get_parameters = @import("get_parameters.zig");
const get_parameters_by_path = @import("get_parameters_by_path.zig");
const get_patch_baseline = @import("get_patch_baseline.zig");
const get_patch_baseline_for_patch_group = @import("get_patch_baseline_for_patch_group.zig");
const get_resource_policies = @import("get_resource_policies.zig");
const get_service_setting = @import("get_service_setting.zig");
const label_parameter_version = @import("label_parameter_version.zig");
const list_association_versions = @import("list_association_versions.zig");
const list_associations = @import("list_associations.zig");
const list_command_invocations = @import("list_command_invocations.zig");
const list_commands = @import("list_commands.zig");
const list_compliance_items = @import("list_compliance_items.zig");
const list_compliance_summaries = @import("list_compliance_summaries.zig");
const list_document_metadata_history = @import("list_document_metadata_history.zig");
const list_document_versions = @import("list_document_versions.zig");
const list_documents = @import("list_documents.zig");
const list_inventory_entries = @import("list_inventory_entries.zig");
const list_nodes = @import("list_nodes.zig");
const list_nodes_summary = @import("list_nodes_summary.zig");
const list_ops_item_events = @import("list_ops_item_events.zig");
const list_ops_item_related_items = @import("list_ops_item_related_items.zig");
const list_ops_metadata = @import("list_ops_metadata.zig");
const list_resource_compliance_summaries = @import("list_resource_compliance_summaries.zig");
const list_resource_data_sync = @import("list_resource_data_sync.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const modify_document_permission = @import("modify_document_permission.zig");
const put_compliance_items = @import("put_compliance_items.zig");
const put_inventory = @import("put_inventory.zig");
const put_parameter = @import("put_parameter.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const register_default_patch_baseline = @import("register_default_patch_baseline.zig");
const register_patch_baseline_for_patch_group = @import("register_patch_baseline_for_patch_group.zig");
const register_target_with_maintenance_window = @import("register_target_with_maintenance_window.zig");
const register_task_with_maintenance_window = @import("register_task_with_maintenance_window.zig");
const remove_tags_from_resource = @import("remove_tags_from_resource.zig");
const reset_service_setting = @import("reset_service_setting.zig");
const resume_session = @import("resume_session.zig");
const send_automation_signal = @import("send_automation_signal.zig");
const send_command = @import("send_command.zig");
const start_access_request = @import("start_access_request.zig");
const start_associations_once = @import("start_associations_once.zig");
const start_automation_execution = @import("start_automation_execution.zig");
const start_change_request_execution = @import("start_change_request_execution.zig");
const start_execution_preview = @import("start_execution_preview.zig");
const start_session = @import("start_session.zig");
const stop_automation_execution = @import("stop_automation_execution.zig");
const terminate_session = @import("terminate_session.zig");
const unlabel_parameter_version = @import("unlabel_parameter_version.zig");
const update_association = @import("update_association.zig");
const update_association_status = @import("update_association_status.zig");
const update_document = @import("update_document.zig");
const update_document_default_version = @import("update_document_default_version.zig");
const update_document_metadata = @import("update_document_metadata.zig");
const update_maintenance_window = @import("update_maintenance_window.zig");
const update_maintenance_window_target = @import("update_maintenance_window_target.zig");
const update_maintenance_window_task = @import("update_maintenance_window_task.zig");
const update_managed_instance_role = @import("update_managed_instance_role.zig");
const update_ops_item = @import("update_ops_item.zig");
const update_ops_metadata = @import("update_ops_metadata.zig");
const update_patch_baseline = @import("update_patch_baseline.zig");
const update_resource_data_sync = @import("update_resource_data_sync.zig");
const update_service_setting = @import("update_service_setting.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSM";

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

    /// Adds or overwrites one or more tags for the specified resource. *Tags*
    /// are metadata that you can assign to your automations, documents, managed
    /// nodes, maintenance
    /// windows, Parameter Store parameters, and patch baselines. Tags enable you to
    /// categorize your
    /// resources in different ways, for example, by purpose, owner, or environment.
    /// Each tag consists of
    /// a key and an optional value, both of which you define. For example, you
    /// could define a set of
    /// tags for your account's managed nodes that helps you track each node's owner
    /// and stack level. For
    /// example:
    ///
    /// * `Key=Owner,Value=DbAdmin`
    ///
    /// * `Key=Owner,Value=SysAdmin`
    ///
    /// * `Key=Owner,Value=Dev`
    ///
    /// * `Key=Stack,Value=Production`
    ///
    /// * `Key=Stack,Value=Pre-Production`
    ///
    /// * `Key=Stack,Value=Test`
    ///
    /// Most resources can have a maximum of 50 tags. Automations can have a maximum
    /// of 5
    /// tags.
    ///
    /// We recommend that you devise a set of tag keys that meets your needs for
    /// each resource type.
    /// Using a consistent set of tag keys makes it easier for you to manage your
    /// resources. You can
    /// search and filter the resources based on the tags you add. Tags don't have
    /// any semantic meaning
    /// to and are interpreted strictly as a string of characters.
    ///
    /// For more information about using tags with Amazon Elastic Compute Cloud
    /// (Amazon EC2) instances, see [Tag your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) in the *Amazon EC2 User Guide*.
    pub fn addTagsToResource(self: *Self, input: add_tags_to_resource.AddTagsToResourceInput, options: add_tags_to_resource.Options) !add_tags_to_resource.AddTagsToResourceOutput {
        return add_tags_to_resource.execute(self, input, options);
    }

    /// Associates a related item to a Systems Manager OpsCenter OpsItem. For
    /// example, you can associate an
    /// Incident Manager incident or analysis with an OpsItem. Incident Manager and
    /// OpsCenter are tools in
    /// Amazon Web Services Systems Manager.
    pub fn associateOpsItemRelatedItem(self: *Self, input: associate_ops_item_related_item.AssociateOpsItemRelatedItemInput, options: associate_ops_item_related_item.Options) !associate_ops_item_related_item.AssociateOpsItemRelatedItemOutput {
        return associate_ops_item_related_item.execute(self, input, options);
    }

    /// Attempts to cancel the command specified by the Command ID. There is no
    /// guarantee that the
    /// command will be terminated and the underlying process stopped.
    pub fn cancelCommand(self: *Self, input: cancel_command.CancelCommandInput, options: cancel_command.Options) !cancel_command.CancelCommandOutput {
        return cancel_command.execute(self, input, options);
    }

    /// Stops a maintenance window execution that is already in progress and cancels
    /// any tasks in
    /// the window that haven't already starting running. Tasks already in progress
    /// will continue to
    /// completion.
    pub fn cancelMaintenanceWindowExecution(self: *Self, input: cancel_maintenance_window_execution.CancelMaintenanceWindowExecutionInput, options: cancel_maintenance_window_execution.Options) !cancel_maintenance_window_execution.CancelMaintenanceWindowExecutionOutput {
        return cancel_maintenance_window_execution.execute(self, input, options);
    }

    /// Generates an activation code and activation ID you can use to register your
    /// on-premises
    /// servers, edge devices, or virtual machine (VM) with Amazon Web Services
    /// Systems Manager. Registering these machines with
    /// Systems Manager makes it possible to manage them using Systems Manager
    /// tools. You use the activation code and ID when
    /// installing SSM Agent on machines in your hybrid environment. For more
    /// information about
    /// requirements for managing on-premises machines using Systems Manager, see
    /// [Using Amazon Web Services Systems Manager in
    /// hybrid and multicloud
    /// environments](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-hybrid-multicloud.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Amazon Elastic Compute Cloud (Amazon EC2) instances, edge devices, and
    /// on-premises servers and VMs that are
    /// configured for Systems Manager are all called *managed nodes*.
    pub fn createActivation(self: *Self, input: create_activation.CreateActivationInput, options: create_activation.Options) !create_activation.CreateActivationOutput {
        return create_activation.execute(self, input, options);
    }

    /// A State Manager association defines the state that you want to maintain on
    /// your managed
    /// nodes. For example, an association can specify that anti-virus software must
    /// be installed and
    /// running on your managed nodes, or that certain ports must be closed. For
    /// static targets, the
    /// association specifies a schedule for when the configuration is reapplied.
    /// For dynamic targets,
    /// such as an Amazon Web Services resource group or an Amazon Web Services
    /// autoscaling group, State Manager, a tool in Amazon Web Services Systems
    /// Manager
    /// applies the configuration when new managed nodes are added to the group. The
    /// association also
    /// specifies actions to take when applying the configuration. For example, an
    /// association for
    /// anti-virus software might run once a day. If the software isn't installed,
    /// then State Manager
    /// installs it. If the software is installed, but the service isn't running,
    /// then the association
    /// might instruct State Manager to start the service.
    pub fn createAssociation(self: *Self, input: create_association.CreateAssociationInput, options: create_association.Options) !create_association.CreateAssociationOutput {
        return create_association.execute(self, input, options);
    }

    /// Associates the specified Amazon Web Services Systems Manager document (SSM
    /// document) with the specified managed nodes
    /// or targets.
    ///
    /// When you associate a document with one or more managed nodes using IDs or
    /// tags, Amazon Web Services Systems Manager
    /// Agent (SSM Agent) running on the managed node processes the document and
    /// configures the node as
    /// specified.
    ///
    /// If you associate a document with a managed node that already has an
    /// associated document, the
    /// system returns the AssociationAlreadyExists exception.
    pub fn createAssociationBatch(self: *Self, input: create_association_batch.CreateAssociationBatchInput, options: create_association_batch.Options) !create_association_batch.CreateAssociationBatchOutput {
        return create_association_batch.execute(self, input, options);
    }

    /// Creates a Amazon Web Services Systems Manager (SSM document). An SSM
    /// document defines the actions that Systems Manager performs
    /// on your managed nodes. For more information about SSM documents, including
    /// information about
    /// supported schemas, features, and syntax, see [Amazon Web Services Systems
    /// Manager
    /// Documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/documents.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn createDocument(self: *Self, input: create_document.CreateDocumentInput, options: create_document.Options) !create_document.CreateDocumentOutput {
        return create_document.execute(self, input, options);
    }

    /// Creates a new maintenance window.
    ///
    /// The value you specify for `Duration` determines the specific end time for
    /// the
    /// maintenance window based on the time it begins. No maintenance window tasks
    /// are permitted to
    /// start after the resulting endtime minus the number of hours you specify for
    /// `Cutoff`.
    /// For example, if the maintenance window starts at 3 PM, the duration is three
    /// hours, and the
    /// value you specify for `Cutoff` is one hour, no maintenance window tasks can
    /// start
    /// after 5 PM.
    pub fn createMaintenanceWindow(self: *Self, input: create_maintenance_window.CreateMaintenanceWindowInput, options: create_maintenance_window.Options) !create_maintenance_window.CreateMaintenanceWindowOutput {
        return create_maintenance_window.execute(self, input, options);
    }

    /// Creates a new OpsItem. You must have permission in Identity and Access
    /// Management (IAM) to create a new OpsItem. For more information, see [Set up
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setup.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Operations engineers and IT professionals use Amazon Web Services Systems
    /// Manager OpsCenter to view, investigate, and
    /// remediate operational issues impacting the performance and health of their
    /// Amazon Web Services resources. For
    /// more information, see [Amazon Web Services Systems Manager
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn createOpsItem(self: *Self, input: create_ops_item.CreateOpsItemInput, options: create_ops_item.Options) !create_ops_item.CreateOpsItemOutput {
        return create_ops_item.execute(self, input, options);
    }

    /// If you create a new application in Application Manager, Amazon Web Services
    /// Systems Manager calls this API operation to specify
    /// information about the new application, including the application type.
    pub fn createOpsMetadata(self: *Self, input: create_ops_metadata.CreateOpsMetadataInput, options: create_ops_metadata.Options) !create_ops_metadata.CreateOpsMetadataOutput {
        return create_ops_metadata.execute(self, input, options);
    }

    /// Creates a patch baseline.
    ///
    /// For information about valid key-value pairs in `PatchFilters` for each
    /// supported
    /// operating system type, see PatchFilter.
    pub fn createPatchBaseline(self: *Self, input: create_patch_baseline.CreatePatchBaselineInput, options: create_patch_baseline.Options) !create_patch_baseline.CreatePatchBaselineOutput {
        return create_patch_baseline.execute(self, input, options);
    }

    /// A resource data sync helps you view data from multiple sources in a single
    /// location.
    /// Amazon Web Services Systems Manager offers two types of resource data sync:
    /// `SyncToDestination` and
    /// `SyncFromSource`.
    ///
    /// You can configure Systems Manager Inventory to use the `SyncToDestination`
    /// type to
    /// synchronize Inventory data from multiple Amazon Web Services Regions to a
    /// single Amazon Simple Storage Service (Amazon S3) bucket. For more
    /// information, see [Creating a
    /// resource data sync for
    /// Inventory](https://docs.aws.amazon.com/systems-manager/latest/userguide/inventory-create-resource-data-sync.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// You can configure Systems Manager Explorer to use the `SyncFromSource` type
    /// to synchronize
    /// operational work items (OpsItems) and operational data (OpsData) from
    /// multiple Amazon Web Services Regions to a
    /// single Amazon S3 bucket. This type can synchronize OpsItems and OpsData from
    /// multiple
    /// Amazon Web Services accounts and Amazon Web Services Regions or
    /// `EntireOrganization` by using Organizations. For more
    /// information, see [Setting up Systems Manager
    /// Explorer to display data from multiple accounts and
    /// Regions](https://docs.aws.amazon.com/systems-manager/latest/userguide/Explorer-resource-data-sync.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// A resource data sync is an asynchronous operation that returns immediately.
    /// After a
    /// successful initial sync is completed, the system continuously syncs data. To
    /// check the status of
    /// a sync, use the ListResourceDataSync.
    ///
    /// By default, data isn't encrypted in Amazon S3. We strongly recommend that
    /// you
    /// enable encryption in Amazon S3 to ensure secure data storage. We also
    /// recommend that you
    /// secure access to the Amazon S3 bucket by creating a restrictive bucket
    /// policy.
    pub fn createResourceDataSync(self: *Self, input: create_resource_data_sync.CreateResourceDataSyncInput, options: create_resource_data_sync.Options) !create_resource_data_sync.CreateResourceDataSyncOutput {
        return create_resource_data_sync.execute(self, input, options);
    }

    /// Deletes an activation. You aren't required to delete an activation. If you
    /// delete an
    /// activation, you can no longer use it to register additional managed nodes.
    /// Deleting an activation
    /// doesn't de-register managed nodes. You must manually de-register managed
    /// nodes.
    pub fn deleteActivation(self: *Self, input: delete_activation.DeleteActivationInput, options: delete_activation.Options) !delete_activation.DeleteActivationOutput {
        return delete_activation.execute(self, input, options);
    }

    /// Disassociates the specified Amazon Web Services Systems Manager document
    /// (SSM document) from the specified managed
    /// node. If you created the association by using the `Targets` parameter, then
    /// you must
    /// delete the association by using the association ID.
    ///
    /// When you disassociate a document from a managed node, it doesn't change the
    /// configuration of
    /// the node. To change the configuration state of a managed node after you
    /// disassociate a document,
    /// you must create a new document with the desired configuration and associate
    /// it with the
    /// node.
    pub fn deleteAssociation(self: *Self, input: delete_association.DeleteAssociationInput, options: delete_association.Options) !delete_association.DeleteAssociationOutput {
        return delete_association.execute(self, input, options);
    }

    /// Deletes the Amazon Web Services Systems Manager document (SSM document) and
    /// all managed node associations to the
    /// document.
    ///
    /// Before you delete the document, we recommend that you use DeleteAssociation
    /// to disassociate all managed nodes that are associated with the document.
    pub fn deleteDocument(self: *Self, input: delete_document.DeleteDocumentInput, options: delete_document.Options) !delete_document.DeleteDocumentOutput {
        return delete_document.execute(self, input, options);
    }

    /// Delete a custom inventory type or the data associated with a custom
    /// Inventory type. Deleting
    /// a custom inventory type is also referred to as deleting a custom inventory
    /// schema.
    pub fn deleteInventory(self: *Self, input: delete_inventory.DeleteInventoryInput, options: delete_inventory.Options) !delete_inventory.DeleteInventoryOutput {
        return delete_inventory.execute(self, input, options);
    }

    /// Deletes a maintenance window.
    pub fn deleteMaintenanceWindow(self: *Self, input: delete_maintenance_window.DeleteMaintenanceWindowInput, options: delete_maintenance_window.Options) !delete_maintenance_window.DeleteMaintenanceWindowOutput {
        return delete_maintenance_window.execute(self, input, options);
    }

    /// Delete an OpsItem. You must have permission in Identity and Access
    /// Management (IAM) to
    /// delete an OpsItem.
    ///
    /// Note the following important information about this operation.
    ///
    /// * Deleting an OpsItem is irreversible. You can't restore a deleted OpsItem.
    ///
    /// * This operation uses an *eventual consistency model*, which means the
    /// system can take a few minutes to complete this operation. If you delete an
    /// OpsItem and
    /// immediately call, for example, GetOpsItem, the deleted OpsItem might still
    /// appear in the response.
    ///
    /// * This operation is idempotent. The system doesn't throw an exception if you
    ///   repeatedly
    /// call this operation for the same OpsItem. If the first call is successful,
    /// all additional calls
    /// return the same successful response as the first call.
    ///
    /// * This operation doesn't support cross-account calls. A delegated
    ///   administrator or
    /// management account can't delete OpsItems in other accounts, even if
    /// OpsCenter has been set up for
    /// cross-account administration. For more information about cross-account
    /// administration, see
    /// [Setting up
    /// OpsCenter to centrally manage OpsItems across
    /// accounts](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setting-up-cross-account.html) in the *Systems Manager User Guide*.
    pub fn deleteOpsItem(self: *Self, input: delete_ops_item.DeleteOpsItemInput, options: delete_ops_item.Options) !delete_ops_item.DeleteOpsItemOutput {
        return delete_ops_item.execute(self, input, options);
    }

    /// Delete OpsMetadata related to an application.
    pub fn deleteOpsMetadata(self: *Self, input: delete_ops_metadata.DeleteOpsMetadataInput, options: delete_ops_metadata.Options) !delete_ops_metadata.DeleteOpsMetadataOutput {
        return delete_ops_metadata.execute(self, input, options);
    }

    /// Delete a parameter from the system. After deleting a parameter, wait for at
    /// least 30 seconds
    /// to create a parameter with the same name.
    pub fn deleteParameter(self: *Self, input: delete_parameter.DeleteParameterInput, options: delete_parameter.Options) !delete_parameter.DeleteParameterOutput {
        return delete_parameter.execute(self, input, options);
    }

    /// Delete a list of parameters. After deleting a parameter, wait for at least
    /// 30 seconds to
    /// create a parameter with the same name.
    pub fn deleteParameters(self: *Self, input: delete_parameters.DeleteParametersInput, options: delete_parameters.Options) !delete_parameters.DeleteParametersOutput {
        return delete_parameters.execute(self, input, options);
    }

    /// Deletes a patch baseline.
    pub fn deletePatchBaseline(self: *Self, input: delete_patch_baseline.DeletePatchBaselineInput, options: delete_patch_baseline.Options) !delete_patch_baseline.DeletePatchBaselineOutput {
        return delete_patch_baseline.execute(self, input, options);
    }

    /// Deletes a resource data sync configuration. After the configuration is
    /// deleted, changes to
    /// data on managed nodes are no longer synced to or from the target. Deleting a
    /// sync configuration
    /// doesn't delete data.
    pub fn deleteResourceDataSync(self: *Self, input: delete_resource_data_sync.DeleteResourceDataSyncInput, options: delete_resource_data_sync.Options) !delete_resource_data_sync.DeleteResourceDataSyncOutput {
        return delete_resource_data_sync.execute(self, input, options);
    }

    /// Deletes a Systems Manager resource policy. A resource policy helps you to
    /// define the IAM entity (for example, an Amazon Web Services account) that can
    /// manage your Systems Manager resources. The following
    /// resources support Systems Manager resource policies.
    ///
    /// * `OpsItemGroup` - The resource policy for `OpsItemGroup` enables
    /// Amazon Web Services accounts to view and interact with OpsCenter operational
    /// work items (OpsItems).
    ///
    /// * `Parameter` - The resource policy is used to share a parameter with other
    /// accounts using Resource Access Manager (RAM). For more information about
    /// cross-account sharing of parameters, see [Working with
    /// shared
    /// parameters](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-shared-parameters.html) in the *Amazon Web Services Systems Manager User Guide*.
    pub fn deleteResourcePolicy(self: *Self, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, input, options);
    }

    /// Removes the server or virtual machine from the list of registered servers.
    ///
    /// If you want to reregister an on-premises server, edge device, or VM, you
    /// must use a
    /// different Activation Code and Activation ID than used to register the
    /// machine previously. The
    /// Activation Code and Activation ID must not have already been used on the
    /// maximum number of
    /// activations specified when they were created. For more information, see
    /// [Deregistering
    /// managed nodes in a hybrid and multicloud
    /// environment](https://docs.aws.amazon.com/systems-manager/latest/userguide/fleet-manager-deregister-hybrid-nodes.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn deregisterManagedInstance(self: *Self, input: deregister_managed_instance.DeregisterManagedInstanceInput, options: deregister_managed_instance.Options) !deregister_managed_instance.DeregisterManagedInstanceOutput {
        return deregister_managed_instance.execute(self, input, options);
    }

    /// Removes a patch group from a patch baseline.
    pub fn deregisterPatchBaselineForPatchGroup(self: *Self, input: deregister_patch_baseline_for_patch_group.DeregisterPatchBaselineForPatchGroupInput, options: deregister_patch_baseline_for_patch_group.Options) !deregister_patch_baseline_for_patch_group.DeregisterPatchBaselineForPatchGroupOutput {
        return deregister_patch_baseline_for_patch_group.execute(self, input, options);
    }

    /// Removes a target from a maintenance window.
    pub fn deregisterTargetFromMaintenanceWindow(self: *Self, input: deregister_target_from_maintenance_window.DeregisterTargetFromMaintenanceWindowInput, options: deregister_target_from_maintenance_window.Options) !deregister_target_from_maintenance_window.DeregisterTargetFromMaintenanceWindowOutput {
        return deregister_target_from_maintenance_window.execute(self, input, options);
    }

    /// Removes a task from a maintenance window.
    pub fn deregisterTaskFromMaintenanceWindow(self: *Self, input: deregister_task_from_maintenance_window.DeregisterTaskFromMaintenanceWindowInput, options: deregister_task_from_maintenance_window.Options) !deregister_task_from_maintenance_window.DeregisterTaskFromMaintenanceWindowOutput {
        return deregister_task_from_maintenance_window.execute(self, input, options);
    }

    /// Describes details about the activation, such as the date and time the
    /// activation was
    /// created, its expiration date, the Identity and Access Management (IAM) role
    /// assigned to
    /// the managed nodes in the activation, and the number of nodes registered by
    /// using this
    /// activation.
    pub fn describeActivations(self: *Self, input: describe_activations.DescribeActivationsInput, options: describe_activations.Options) !describe_activations.DescribeActivationsOutput {
        return describe_activations.execute(self, input, options);
    }

    /// Describes the association for the specified target or managed node. If you
    /// created the
    /// association by using the `Targets` parameter, then you must retrieve the
    /// association
    /// by using the association ID.
    pub fn describeAssociation(self: *Self, input: describe_association.DescribeAssociationInput, options: describe_association.Options) !describe_association.DescribeAssociationOutput {
        return describe_association.execute(self, input, options);
    }

    /// Views information about a specific execution of a specific association.
    pub fn describeAssociationExecutionTargets(self: *Self, input: describe_association_execution_targets.DescribeAssociationExecutionTargetsInput, options: describe_association_execution_targets.Options) !describe_association_execution_targets.DescribeAssociationExecutionTargetsOutput {
        return describe_association_execution_targets.execute(self, input, options);
    }

    /// Views all executions for a specific association ID.
    pub fn describeAssociationExecutions(self: *Self, input: describe_association_executions.DescribeAssociationExecutionsInput, options: describe_association_executions.Options) !describe_association_executions.DescribeAssociationExecutionsOutput {
        return describe_association_executions.execute(self, input, options);
    }

    /// Provides details about all active and terminated Automation executions.
    pub fn describeAutomationExecutions(self: *Self, input: describe_automation_executions.DescribeAutomationExecutionsInput, options: describe_automation_executions.Options) !describe_automation_executions.DescribeAutomationExecutionsOutput {
        return describe_automation_executions.execute(self, input, options);
    }

    /// Information about all active and terminated step executions in an Automation
    /// workflow.
    pub fn describeAutomationStepExecutions(self: *Self, input: describe_automation_step_executions.DescribeAutomationStepExecutionsInput, options: describe_automation_step_executions.Options) !describe_automation_step_executions.DescribeAutomationStepExecutionsOutput {
        return describe_automation_step_executions.execute(self, input, options);
    }

    /// Lists all patches eligible to be included in a patch baseline.
    ///
    /// Currently, `DescribeAvailablePatches` supports only the Amazon Linux 1,
    /// Amazon
    /// Linux 2, and Windows Server operating systems.
    pub fn describeAvailablePatches(self: *Self, input: describe_available_patches.DescribeAvailablePatchesInput, options: describe_available_patches.Options) !describe_available_patches.DescribeAvailablePatchesOutput {
        return describe_available_patches.execute(self, input, options);
    }

    /// Describes the specified Amazon Web Services Systems Manager document (SSM
    /// document).
    pub fn describeDocument(self: *Self, input: describe_document.DescribeDocumentInput, options: describe_document.Options) !describe_document.DescribeDocumentOutput {
        return describe_document.execute(self, input, options);
    }

    /// Describes the permissions for a Amazon Web Services Systems Manager document
    /// (SSM document). If you created the
    /// document, you are the owner. If a document is shared, it can either be
    /// shared privately (by
    /// specifying a user's Amazon Web Services account ID) or publicly (*All*).
    pub fn describeDocumentPermission(self: *Self, input: describe_document_permission.DescribeDocumentPermissionInput, options: describe_document_permission.Options) !describe_document_permission.DescribeDocumentPermissionOutput {
        return describe_document_permission.execute(self, input, options);
    }

    /// All associations for the managed nodes.
    pub fn describeEffectiveInstanceAssociations(self: *Self, input: describe_effective_instance_associations.DescribeEffectiveInstanceAssociationsInput, options: describe_effective_instance_associations.Options) !describe_effective_instance_associations.DescribeEffectiveInstanceAssociationsOutput {
        return describe_effective_instance_associations.execute(self, input, options);
    }

    /// Retrieves the current effective patches (the patch and the approval state)
    /// for the specified
    /// patch baseline. Applies to patch baselines for Windows only.
    pub fn describeEffectivePatchesForPatchBaseline(self: *Self, input: describe_effective_patches_for_patch_baseline.DescribeEffectivePatchesForPatchBaselineInput, options: describe_effective_patches_for_patch_baseline.Options) !describe_effective_patches_for_patch_baseline.DescribeEffectivePatchesForPatchBaselineOutput {
        return describe_effective_patches_for_patch_baseline.execute(self, input, options);
    }

    /// The status of the associations for the managed nodes.
    pub fn describeInstanceAssociationsStatus(self: *Self, input: describe_instance_associations_status.DescribeInstanceAssociationsStatusInput, options: describe_instance_associations_status.Options) !describe_instance_associations_status.DescribeInstanceAssociationsStatusOutput {
        return describe_instance_associations_status.execute(self, input, options);
    }

    /// Provides information about one or more of your managed nodes, including the
    /// operating system
    /// platform, SSM Agent version, association status, and IP address. This
    /// operation does not return
    /// information for nodes that are either Stopped or Terminated.
    ///
    /// If you specify one or more node IDs, the operation returns information for
    /// those managed
    /// nodes. If you don't specify node IDs, it returns information for all your
    /// managed nodes. If you
    /// specify a node ID that isn't valid or a node that you don't own, you receive
    /// an error.
    ///
    /// The `IamRole` field returned for this API operation is the role assigned to
    /// an
    /// Amazon EC2 instance configured with a Systems Manager Quick Setup host
    /// management configuration or
    /// the role assigned to an on-premises managed node.
    pub fn describeInstanceInformation(self: *Self, input: describe_instance_information.DescribeInstanceInformationInput, options: describe_instance_information.Options) !describe_instance_information.DescribeInstanceInformationOutput {
        return describe_instance_information.execute(self, input, options);
    }

    /// Retrieves the high-level patch state of one or more managed nodes.
    pub fn describeInstancePatchStates(self: *Self, input: describe_instance_patch_states.DescribeInstancePatchStatesInput, options: describe_instance_patch_states.Options) !describe_instance_patch_states.DescribeInstancePatchStatesOutput {
        return describe_instance_patch_states.execute(self, input, options);
    }

    /// Retrieves the high-level patch state for the managed nodes in the specified
    /// patch
    /// group.
    pub fn describeInstancePatchStatesForPatchGroup(self: *Self, input: describe_instance_patch_states_for_patch_group.DescribeInstancePatchStatesForPatchGroupInput, options: describe_instance_patch_states_for_patch_group.Options) !describe_instance_patch_states_for_patch_group.DescribeInstancePatchStatesForPatchGroupOutput {
        return describe_instance_patch_states_for_patch_group.execute(self, input, options);
    }

    /// Retrieves information about the patches on the specified managed node and
    /// their state
    /// relative to the patch baseline being used for the node.
    pub fn describeInstancePatches(self: *Self, input: describe_instance_patches.DescribeInstancePatchesInput, options: describe_instance_patches.Options) !describe_instance_patches.DescribeInstancePatchesOutput {
        return describe_instance_patches.execute(self, input, options);
    }

    /// An API operation used by the Systems Manager console to display information
    /// about Systems Manager managed
    /// nodes.
    pub fn describeInstanceProperties(self: *Self, input: describe_instance_properties.DescribeInstancePropertiesInput, options: describe_instance_properties.Options) !describe_instance_properties.DescribeInstancePropertiesOutput {
        return describe_instance_properties.execute(self, input, options);
    }

    /// Describes a specific delete inventory operation.
    pub fn describeInventoryDeletions(self: *Self, input: describe_inventory_deletions.DescribeInventoryDeletionsInput, options: describe_inventory_deletions.Options) !describe_inventory_deletions.DescribeInventoryDeletionsOutput {
        return describe_inventory_deletions.execute(self, input, options);
    }

    /// Retrieves the individual task executions (one per target) for a particular
    /// task run as part
    /// of a maintenance window execution.
    pub fn describeMaintenanceWindowExecutionTaskInvocations(self: *Self, input: describe_maintenance_window_execution_task_invocations.DescribeMaintenanceWindowExecutionTaskInvocationsInput, options: describe_maintenance_window_execution_task_invocations.Options) !describe_maintenance_window_execution_task_invocations.DescribeMaintenanceWindowExecutionTaskInvocationsOutput {
        return describe_maintenance_window_execution_task_invocations.execute(self, input, options);
    }

    /// For a given maintenance window execution, lists the tasks that were run.
    pub fn describeMaintenanceWindowExecutionTasks(self: *Self, input: describe_maintenance_window_execution_tasks.DescribeMaintenanceWindowExecutionTasksInput, options: describe_maintenance_window_execution_tasks.Options) !describe_maintenance_window_execution_tasks.DescribeMaintenanceWindowExecutionTasksOutput {
        return describe_maintenance_window_execution_tasks.execute(self, input, options);
    }

    /// Lists the executions of a maintenance window. This includes information
    /// about when the
    /// maintenance window was scheduled to be active, and information about tasks
    /// registered and run
    /// with the maintenance window.
    pub fn describeMaintenanceWindowExecutions(self: *Self, input: describe_maintenance_window_executions.DescribeMaintenanceWindowExecutionsInput, options: describe_maintenance_window_executions.Options) !describe_maintenance_window_executions.DescribeMaintenanceWindowExecutionsOutput {
        return describe_maintenance_window_executions.execute(self, input, options);
    }

    /// Retrieves information about upcoming executions of a maintenance window.
    pub fn describeMaintenanceWindowSchedule(self: *Self, input: describe_maintenance_window_schedule.DescribeMaintenanceWindowScheduleInput, options: describe_maintenance_window_schedule.Options) !describe_maintenance_window_schedule.DescribeMaintenanceWindowScheduleOutput {
        return describe_maintenance_window_schedule.execute(self, input, options);
    }

    /// Lists the targets registered with the maintenance window.
    pub fn describeMaintenanceWindowTargets(self: *Self, input: describe_maintenance_window_targets.DescribeMaintenanceWindowTargetsInput, options: describe_maintenance_window_targets.Options) !describe_maintenance_window_targets.DescribeMaintenanceWindowTargetsOutput {
        return describe_maintenance_window_targets.execute(self, input, options);
    }

    /// Lists the tasks in a maintenance window.
    ///
    /// For maintenance window tasks without a specified target, you can't supply
    /// values for
    /// `--max-errors` and `--max-concurrency`. Instead, the system inserts a
    /// placeholder value of `1`, which may be reported in the response to this
    /// command.
    /// These values don't affect the running of your task and can be ignored.
    pub fn describeMaintenanceWindowTasks(self: *Self, input: describe_maintenance_window_tasks.DescribeMaintenanceWindowTasksInput, options: describe_maintenance_window_tasks.Options) !describe_maintenance_window_tasks.DescribeMaintenanceWindowTasksOutput {
        return describe_maintenance_window_tasks.execute(self, input, options);
    }

    /// Retrieves the maintenance windows in an Amazon Web Services account.
    pub fn describeMaintenanceWindows(self: *Self, input: describe_maintenance_windows.DescribeMaintenanceWindowsInput, options: describe_maintenance_windows.Options) !describe_maintenance_windows.DescribeMaintenanceWindowsOutput {
        return describe_maintenance_windows.execute(self, input, options);
    }

    /// Retrieves information about the maintenance window targets or tasks that a
    /// managed node is
    /// associated with.
    pub fn describeMaintenanceWindowsForTarget(self: *Self, input: describe_maintenance_windows_for_target.DescribeMaintenanceWindowsForTargetInput, options: describe_maintenance_windows_for_target.Options) !describe_maintenance_windows_for_target.DescribeMaintenanceWindowsForTargetOutput {
        return describe_maintenance_windows_for_target.execute(self, input, options);
    }

    /// Query a set of OpsItems. You must have permission in Identity and Access
    /// Management (IAM) to query a list of OpsItems. For more information, see [Set
    /// up
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setup.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Operations engineers and IT professionals use Amazon Web Services Systems
    /// Manager OpsCenter to view, investigate, and
    /// remediate operational issues impacting the performance and health of their
    /// Amazon Web Services resources. For
    /// more information, see [Amazon Web Services Systems Manager
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn describeOpsItems(self: *Self, input: describe_ops_items.DescribeOpsItemsInput, options: describe_ops_items.Options) !describe_ops_items.DescribeOpsItemsOutput {
        return describe_ops_items.execute(self, input, options);
    }

    /// Lists the parameters in your Amazon Web Services account or the parameters
    /// shared with you when you enable
    /// the
    /// [Shared](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DescribeParameters.html#systemsmanager-DescribeParameters-request-Shared) option.
    ///
    /// Request results are returned on a best-effort basis. If you specify
    /// `MaxResults`
    /// in the request, the response includes information up to the limit specified.
    /// The number of items
    /// returned, however, can be between zero and the value of `MaxResults`. If the
    /// service
    /// reaches an internal limit while processing the results, it stops the
    /// operation and returns the
    /// matching values up to that point and a `NextToken`. You can specify the
    /// `NextToken` in a subsequent call to get the next set of results.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    ///
    /// If you change the KMS key alias for the KMS key used to encrypt a parameter,
    /// then you must also update the key alias the parameter uses to reference KMS.
    /// Otherwise,
    /// `DescribeParameters` retrieves whatever the original key alias was
    /// referencing.
    pub fn describeParameters(self: *Self, input: describe_parameters.DescribeParametersInput, options: describe_parameters.Options) !describe_parameters.DescribeParametersOutput {
        return describe_parameters.execute(self, input, options);
    }

    /// Lists the patch baselines in your Amazon Web Services account.
    pub fn describePatchBaselines(self: *Self, input: describe_patch_baselines.DescribePatchBaselinesInput, options: describe_patch_baselines.Options) !describe_patch_baselines.DescribePatchBaselinesOutput {
        return describe_patch_baselines.execute(self, input, options);
    }

    /// Returns high-level aggregated patch compliance state information for a patch
    /// group.
    pub fn describePatchGroupState(self: *Self, input: describe_patch_group_state.DescribePatchGroupStateInput, options: describe_patch_group_state.Options) !describe_patch_group_state.DescribePatchGroupStateOutput {
        return describe_patch_group_state.execute(self, input, options);
    }

    /// Lists all patch groups that have been registered with patch baselines.
    pub fn describePatchGroups(self: *Self, input: describe_patch_groups.DescribePatchGroupsInput, options: describe_patch_groups.Options) !describe_patch_groups.DescribePatchGroupsOutput {
        return describe_patch_groups.execute(self, input, options);
    }

    /// Lists the properties of available patches organized by product, product
    /// family,
    /// classification, severity, and other properties of available patches. You can
    /// use the reported
    /// properties in the filters you specify in requests for operations such as
    /// CreatePatchBaseline, UpdatePatchBaseline, DescribeAvailablePatches, and
    /// DescribePatchBaselines.
    ///
    /// The following section lists the properties that can be used in filters for
    /// each major
    /// operating system type:
    ///
    /// **AMAZON_LINUX**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **AMAZON_LINUX_2**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **AMAZON_LINUX_2023**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **CENTOS**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **DEBIAN**
    ///
    /// Valid properties: `PRODUCT` | `PRIORITY`
    ///
    /// **MACOS**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION`
    ///
    /// **ORACLE_LINUX**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **REDHAT_ENTERPRISE_LINUX**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **SUSE**
    ///
    /// Valid properties: `PRODUCT` | `CLASSIFICATION` |
    /// `SEVERITY`
    ///
    /// **UBUNTU**
    ///
    /// Valid properties: `PRODUCT` | `PRIORITY`
    ///
    /// **WINDOWS**
    ///
    /// Valid properties: `PRODUCT` | `PRODUCT_FAMILY` |
    /// `CLASSIFICATION` | `MSRC_SEVERITY`
    pub fn describePatchProperties(self: *Self, input: describe_patch_properties.DescribePatchPropertiesInput, options: describe_patch_properties.Options) !describe_patch_properties.DescribePatchPropertiesOutput {
        return describe_patch_properties.execute(self, input, options);
    }

    /// Retrieves a list of all active sessions (both connected and disconnected) or
    /// terminated
    /// sessions from the past 30 days.
    pub fn describeSessions(self: *Self, input: describe_sessions.DescribeSessionsInput, options: describe_sessions.Options) !describe_sessions.DescribeSessionsOutput {
        return describe_sessions.execute(self, input, options);
    }

    /// Deletes the association between an OpsItem and a related item. For example,
    /// this API
    /// operation can delete an Incident Manager incident from an OpsItem. Incident
    /// Manager is a tool in
    /// Amazon Web Services Systems Manager.
    pub fn disassociateOpsItemRelatedItem(self: *Self, input: disassociate_ops_item_related_item.DisassociateOpsItemRelatedItemInput, options: disassociate_ops_item_related_item.Options) !disassociate_ops_item_related_item.DisassociateOpsItemRelatedItemOutput {
        return disassociate_ops_item_related_item.execute(self, input, options);
    }

    /// Returns a credentials set to be used with just-in-time node access.
    pub fn getAccessToken(self: *Self, input: get_access_token.GetAccessTokenInput, options: get_access_token.Options) !get_access_token.GetAccessTokenOutput {
        return get_access_token.execute(self, input, options);
    }

    /// Get detailed information about a particular Automation execution.
    pub fn getAutomationExecution(self: *Self, input: get_automation_execution.GetAutomationExecutionInput, options: get_automation_execution.Options) !get_automation_execution.GetAutomationExecutionOutput {
        return get_automation_execution.execute(self, input, options);
    }

    /// Gets the state of a Amazon Web Services Systems Manager change calendar at
    /// the current time or a specified time. If
    /// you specify a time, `GetCalendarState` returns the state of the calendar at
    /// that
    /// specific time, and returns the next time that the change calendar state will
    /// transition. If you
    /// don't specify a time, `GetCalendarState` uses the current time. Change
    /// Calendar
    /// entries have two possible states: `OPEN` or `CLOSED`.
    ///
    /// If you specify more than one calendar in a request, the command returns the
    /// status of
    /// `OPEN` only if all calendars in the request are open. If one or more
    /// calendars in the
    /// request are closed, the status returned is `CLOSED`.
    ///
    /// For more information about Change Calendar, a tool in Amazon Web Services
    /// Systems Manager, see [Amazon Web Services Systems Manager Change
    /// Calendar](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-change-calendar.html) in the *Amazon Web Services Systems Manager User Guide*.
    pub fn getCalendarState(self: *Self, input: get_calendar_state.GetCalendarStateInput, options: get_calendar_state.Options) !get_calendar_state.GetCalendarStateOutput {
        return get_calendar_state.execute(self, input, options);
    }

    /// Returns detailed information about command execution for an invocation or
    /// plugin. The Run
    /// Command API follows an eventual consistency model, due to the distributed
    /// nature of the system
    /// supporting the API. This means that the result of an API command you run
    /// that affects your
    /// resources might not be immediately visible to all subsequent commands you
    /// run. You should keep
    /// this in mind when you carry out an API command that immediately follows a
    /// previous API
    /// command.
    ///
    /// `GetCommandInvocation` only gives the execution status of a plugin in a
    /// document.
    /// To get the command execution status on a specific managed node, use
    /// ListCommandInvocations. To get the command execution status across managed
    /// nodes,
    /// use ListCommands.
    pub fn getCommandInvocation(self: *Self, input: get_command_invocation.GetCommandInvocationInput, options: get_command_invocation.Options) !get_command_invocation.GetCommandInvocationOutput {
        return get_command_invocation.execute(self, input, options);
    }

    /// Retrieves the Session Manager connection status for a managed node to
    /// determine whether it is running
    /// and ready to receive Session Manager connections.
    pub fn getConnectionStatus(self: *Self, input: get_connection_status.GetConnectionStatusInput, options: get_connection_status.Options) !get_connection_status.GetConnectionStatusOutput {
        return get_connection_status.execute(self, input, options);
    }

    /// Retrieves the default patch baseline. Amazon Web Services Systems Manager
    /// supports creating multiple default patch
    /// baselines. For example, you can create a default patch baseline for each
    /// operating system.
    ///
    /// If you don't specify an operating system value, the default patch baseline
    /// for Windows is
    /// returned.
    pub fn getDefaultPatchBaseline(self: *Self, input: get_default_patch_baseline.GetDefaultPatchBaselineInput, options: get_default_patch_baseline.Options) !get_default_patch_baseline.GetDefaultPatchBaselineOutput {
        return get_default_patch_baseline.execute(self, input, options);
    }

    /// Retrieves the current snapshot for the patch baseline the managed node uses.
    /// This API is
    /// primarily used by the `AWS-RunPatchBaseline` Systems Manager document (SSM
    /// document).
    ///
    /// If you run the command locally, such as with the Command Line Interface
    /// (CLI), the system attempts to use your local Amazon Web Services credentials
    /// and the operation fails. To avoid
    /// this, you can run the command in the Amazon Web Services Systems Manager
    /// console. Use Run Command, a tool in Amazon Web Services Systems Manager,
    /// with an SSM document that enables you to target a managed node with a script
    /// or command. For
    /// example, run the command using the `AWS-RunShellScript` document or the
    /// `AWS-RunPowerShellScript` document.
    pub fn getDeployablePatchSnapshotForInstance(self: *Self, input: get_deployable_patch_snapshot_for_instance.GetDeployablePatchSnapshotForInstanceInput, options: get_deployable_patch_snapshot_for_instance.Options) !get_deployable_patch_snapshot_for_instance.GetDeployablePatchSnapshotForInstanceOutput {
        return get_deployable_patch_snapshot_for_instance.execute(self, input, options);
    }

    /// Gets the contents of the specified Amazon Web Services Systems Manager
    /// document (SSM document).
    pub fn getDocument(self: *Self, input: get_document.GetDocumentInput, options: get_document.Options) !get_document.GetDocumentOutput {
        return get_document.execute(self, input, options);
    }

    /// Initiates the process of retrieving an existing preview that shows the
    /// effects that running
    /// a specified Automation runbook would have on the targeted resources.
    pub fn getExecutionPreview(self: *Self, input: get_execution_preview.GetExecutionPreviewInput, options: get_execution_preview.Options) !get_execution_preview.GetExecutionPreviewOutput {
        return get_execution_preview.execute(self, input, options);
    }

    /// Query inventory information. This includes managed node status, such as
    /// `Stopped`
    /// or `Terminated`.
    pub fn getInventory(self: *Self, input: get_inventory.GetInventoryInput, options: get_inventory.Options) !get_inventory.GetInventoryOutput {
        return get_inventory.execute(self, input, options);
    }

    /// Return a list of inventory type names for the account, or return a list of
    /// attribute names
    /// for a specific Inventory item type.
    pub fn getInventorySchema(self: *Self, input: get_inventory_schema.GetInventorySchemaInput, options: get_inventory_schema.Options) !get_inventory_schema.GetInventorySchemaOutput {
        return get_inventory_schema.execute(self, input, options);
    }

    /// Retrieves a maintenance window.
    pub fn getMaintenanceWindow(self: *Self, input: get_maintenance_window.GetMaintenanceWindowInput, options: get_maintenance_window.Options) !get_maintenance_window.GetMaintenanceWindowOutput {
        return get_maintenance_window.execute(self, input, options);
    }

    /// Retrieves details about a specific a maintenance window execution.
    pub fn getMaintenanceWindowExecution(self: *Self, input: get_maintenance_window_execution.GetMaintenanceWindowExecutionInput, options: get_maintenance_window_execution.Options) !get_maintenance_window_execution.GetMaintenanceWindowExecutionOutput {
        return get_maintenance_window_execution.execute(self, input, options);
    }

    /// Retrieves the details about a specific task run as part of a maintenance
    /// window
    /// execution.
    pub fn getMaintenanceWindowExecutionTask(self: *Self, input: get_maintenance_window_execution_task.GetMaintenanceWindowExecutionTaskInput, options: get_maintenance_window_execution_task.Options) !get_maintenance_window_execution_task.GetMaintenanceWindowExecutionTaskOutput {
        return get_maintenance_window_execution_task.execute(self, input, options);
    }

    /// Retrieves information about a specific task running on a specific target.
    pub fn getMaintenanceWindowExecutionTaskInvocation(self: *Self, input: get_maintenance_window_execution_task_invocation.GetMaintenanceWindowExecutionTaskInvocationInput, options: get_maintenance_window_execution_task_invocation.Options) !get_maintenance_window_execution_task_invocation.GetMaintenanceWindowExecutionTaskInvocationOutput {
        return get_maintenance_window_execution_task_invocation.execute(self, input, options);
    }

    /// Retrieves the details of a maintenance window task.
    ///
    /// For maintenance window tasks without a specified target, you can't supply
    /// values for
    /// `--max-errors` and `--max-concurrency`. Instead, the system inserts a
    /// placeholder value of `1`, which may be reported in the response to this
    /// command.
    /// These values don't affect the running of your task and can be ignored.
    ///
    /// To retrieve a list of tasks in a maintenance window, instead use the
    /// DescribeMaintenanceWindowTasks command.
    pub fn getMaintenanceWindowTask(self: *Self, input: get_maintenance_window_task.GetMaintenanceWindowTaskInput, options: get_maintenance_window_task.Options) !get_maintenance_window_task.GetMaintenanceWindowTaskOutput {
        return get_maintenance_window_task.execute(self, input, options);
    }

    /// Get information about an OpsItem by using the ID. You must have permission
    /// in Identity and Access Management (IAM) to view information about an
    /// OpsItem. For more information,
    /// see [Set
    /// up
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setup.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Operations engineers and IT professionals use Amazon Web Services Systems
    /// Manager OpsCenter to view, investigate, and
    /// remediate operational issues impacting the performance and health of their
    /// Amazon Web Services resources. For
    /// more information, see [Amazon Web Services Systems Manager
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn getOpsItem(self: *Self, input: get_ops_item.GetOpsItemInput, options: get_ops_item.Options) !get_ops_item.GetOpsItemOutput {
        return get_ops_item.execute(self, input, options);
    }

    /// View operational metadata related to an application in Application Manager.
    pub fn getOpsMetadata(self: *Self, input: get_ops_metadata.GetOpsMetadataInput, options: get_ops_metadata.Options) !get_ops_metadata.GetOpsMetadataOutput {
        return get_ops_metadata.execute(self, input, options);
    }

    /// View a summary of operations metadata (OpsData) based on specified filters
    /// and aggregators.
    /// OpsData can include information about Amazon Web Services Systems Manager
    /// OpsCenter operational workitems (OpsItems) as
    /// well as information about any Amazon Web Services resource or service
    /// configured to report OpsData to Amazon Web Services Systems Manager
    /// Explorer.
    pub fn getOpsSummary(self: *Self, input: get_ops_summary.GetOpsSummaryInput, options: get_ops_summary.Options) !get_ops_summary.GetOpsSummaryOutput {
        return get_ops_summary.execute(self, input, options);
    }

    /// Get information about a single parameter by specifying the parameter name.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    ///
    /// To get information about more than one parameter at a time, use the
    /// GetParameters operation.
    pub fn getParameter(self: *Self, input: get_parameter.GetParameterInput, options: get_parameter.Options) !get_parameter.GetParameterOutput {
        return get_parameter.execute(self, input, options);
    }

    /// Retrieves the history of all changes to a parameter.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    ///
    /// If you change the KMS key alias for the KMS key used to encrypt a parameter,
    /// then you must also update the key alias the parameter uses to reference KMS.
    /// Otherwise,
    /// `GetParameterHistory` retrieves whatever the original key alias was
    /// referencing.
    pub fn getParameterHistory(self: *Self, input: get_parameter_history.GetParameterHistoryInput, options: get_parameter_history.Options) !get_parameter_history.GetParameterHistoryOutput {
        return get_parameter_history.execute(self, input, options);
    }

    /// Get information about one or more parameters by specifying multiple
    /// parameter names.
    ///
    /// To get information about a single parameter, you can use the GetParameter
    /// operation instead.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    pub fn getParameters(self: *Self, input: get_parameters.GetParametersInput, options: get_parameters.Options) !get_parameters.GetParametersOutput {
        return get_parameters.execute(self, input, options);
    }

    /// Retrieve information about one or more parameters under a specified level in
    /// a hierarchy.
    ///
    /// Request results are returned on a best-effort basis. If you specify
    /// `MaxResults`
    /// in the request, the response includes information up to the limit specified.
    /// The number of items
    /// returned, however, can be between zero and the value of `MaxResults`. If the
    /// service
    /// reaches an internal limit while processing the results, it stops the
    /// operation and returns the
    /// matching values up to that point and a `NextToken`. You can specify the
    /// `NextToken` in a subsequent call to get the next set of results.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    pub fn getParametersByPath(self: *Self, input: get_parameters_by_path.GetParametersByPathInput, options: get_parameters_by_path.Options) !get_parameters_by_path.GetParametersByPathOutput {
        return get_parameters_by_path.execute(self, input, options);
    }

    /// Retrieves information about a patch baseline.
    pub fn getPatchBaseline(self: *Self, input: get_patch_baseline.GetPatchBaselineInput, options: get_patch_baseline.Options) !get_patch_baseline.GetPatchBaselineOutput {
        return get_patch_baseline.execute(self, input, options);
    }

    /// Retrieves the patch baseline that should be used for the specified patch
    /// group.
    pub fn getPatchBaselineForPatchGroup(self: *Self, input: get_patch_baseline_for_patch_group.GetPatchBaselineForPatchGroupInput, options: get_patch_baseline_for_patch_group.Options) !get_patch_baseline_for_patch_group.GetPatchBaselineForPatchGroupOutput {
        return get_patch_baseline_for_patch_group.execute(self, input, options);
    }

    /// Returns an array of the `Policy` object.
    pub fn getResourcePolicies(self: *Self, input: get_resource_policies.GetResourcePoliciesInput, options: get_resource_policies.Options) !get_resource_policies.GetResourcePoliciesOutput {
        return get_resource_policies.execute(self, input, options);
    }

    /// `ServiceSetting` is an account-level setting for an Amazon Web Services
    /// service. This setting
    /// defines how a user interacts with or uses a service or a feature of a
    /// service. For example, if an
    /// Amazon Web Services service charges money to the account based on feature or
    /// service usage, then the Amazon Web Services
    /// service team might create a default setting of `false`. This means the user
    /// can't use
    /// this feature unless they change the setting to `true` and intentionally opt
    /// in for a
    /// paid feature.
    ///
    /// Services map a `SettingId` object to a setting value. Amazon Web Services
    /// services teams define
    /// the default value for a `SettingId`. You can't create a new `SettingId`,
    /// but you can overwrite the default value if you have the
    /// `ssm:UpdateServiceSetting`
    /// permission for the setting. Use the UpdateServiceSetting API operation to
    /// change the default setting. Or use the ResetServiceSetting to change the
    /// value
    /// back to the original value defined by the Amazon Web Services service team.
    ///
    /// Query the current service setting for the Amazon Web Services account.
    pub fn getServiceSetting(self: *Self, input: get_service_setting.GetServiceSettingInput, options: get_service_setting.Options) !get_service_setting.GetServiceSettingOutput {
        return get_service_setting.execute(self, input, options);
    }

    /// A parameter label is a user-defined alias to help you manage different
    /// versions of a
    /// parameter. When you modify a parameter, Amazon Web Services Systems Manager
    /// automatically saves a new version and
    /// increments the version number by one. A label can help you remember the
    /// purpose of a parameter
    /// when there are multiple versions.
    ///
    /// Parameter labels have the following requirements and restrictions.
    ///
    /// * A version of a parameter can have a maximum of 10 labels.
    ///
    /// * You can't attach the same label to different versions of the same
    ///   parameter. For example,
    /// if version 1 has the label Production, then you can't attach Production to
    /// version 2.
    ///
    /// * You can move a label from one version of a parameter to another.
    ///
    /// * You can't create a label when you create a new parameter. You must attach
    ///   a label to a
    /// specific version of a parameter.
    ///
    /// * If you no longer want to use a parameter label, then you can either delete
    ///   it or move it
    /// to a different version of a parameter.
    ///
    /// * A label can have a maximum of 100 characters.
    ///
    /// * Labels can contain letters (case sensitive), numbers, periods (.), hyphens
    ///   (-), or
    /// underscores (_).
    ///
    /// * Labels can't begin with a number, "`aws`" or "`ssm`" (not case
    /// sensitive). If a label fails to meet these requirements, then the label
    /// isn't associated with a
    /// parameter and the system displays it in the list of InvalidLabels.
    ///
    /// * Parameter names can't contain spaces. The service removes any spaces
    ///   specified for
    /// the beginning or end of a parameter name. If the specified name for a
    /// parameter contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    pub fn labelParameterVersion(self: *Self, input: label_parameter_version.LabelParameterVersionInput, options: label_parameter_version.Options) !label_parameter_version.LabelParameterVersionOutput {
        return label_parameter_version.execute(self, input, options);
    }

    /// Retrieves all versions of an association for a specific association ID.
    pub fn listAssociationVersions(self: *Self, input: list_association_versions.ListAssociationVersionsInput, options: list_association_versions.Options) !list_association_versions.ListAssociationVersionsOutput {
        return list_association_versions.execute(self, input, options);
    }

    /// Returns all State Manager associations in the current Amazon Web Services
    /// account and Amazon Web Services Region. You
    /// can limit the results to a specific State Manager association document or
    /// managed node by
    /// specifying a filter. State Manager is a tool in Amazon Web Services Systems
    /// Manager.
    pub fn listAssociations(self: *Self, input: list_associations.ListAssociationsInput, options: list_associations.Options) !list_associations.ListAssociationsOutput {
        return list_associations.execute(self, input, options);
    }

    /// An invocation is copy of a command sent to a specific managed node. A
    /// command can apply to
    /// one or more managed nodes. A command invocation applies to one managed node.
    /// For example, if a
    /// user runs `SendCommand` against three managed nodes, then a command
    /// invocation is
    /// created for each requested managed node ID. `ListCommandInvocations` provide
    /// status
    /// about command execution.
    pub fn listCommandInvocations(self: *Self, input: list_command_invocations.ListCommandInvocationsInput, options: list_command_invocations.Options) !list_command_invocations.ListCommandInvocationsOutput {
        return list_command_invocations.execute(self, input, options);
    }

    /// Lists the commands requested by users of the Amazon Web Services account.
    pub fn listCommands(self: *Self, input: list_commands.ListCommandsInput, options: list_commands.Options) !list_commands.ListCommandsOutput {
        return list_commands.execute(self, input, options);
    }

    /// For a specified resource ID, this API operation returns a list of compliance
    /// statuses for
    /// different resource types. Currently, you can only specify one resource ID
    /// per call. List results
    /// depend on the criteria specified in the filter.
    pub fn listComplianceItems(self: *Self, input: list_compliance_items.ListComplianceItemsInput, options: list_compliance_items.Options) !list_compliance_items.ListComplianceItemsOutput {
        return list_compliance_items.execute(self, input, options);
    }

    /// Returns a summary count of compliant and non-compliant resources for a
    /// compliance type. For
    /// example, this call can return State Manager associations, patches, or custom
    /// compliance types
    /// according to the filter criteria that you specify.
    pub fn listComplianceSummaries(self: *Self, input: list_compliance_summaries.ListComplianceSummariesInput, options: list_compliance_summaries.Options) !list_compliance_summaries.ListComplianceSummariesOutput {
        return list_compliance_summaries.execute(self, input, options);
    }

    /// Amazon Web Services Systems Manager Change Manager will no longer be open to
    /// new
    /// customers starting November 7, 2025. If you would like to use Change
    /// Manager, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [Amazon Web Services Systems Manager Change Manager availability
    /// change](https://docs.aws.amazon.com/systems-manager/latest/userguide/change-manager-availability-change.html).
    ///
    /// Information about approval reviews for a version of a change template in
    /// Change Manager.
    pub fn listDocumentMetadataHistory(self: *Self, input: list_document_metadata_history.ListDocumentMetadataHistoryInput, options: list_document_metadata_history.Options) !list_document_metadata_history.ListDocumentMetadataHistoryOutput {
        return list_document_metadata_history.execute(self, input, options);
    }

    /// List all versions for a document.
    pub fn listDocumentVersions(self: *Self, input: list_document_versions.ListDocumentVersionsInput, options: list_document_versions.Options) !list_document_versions.ListDocumentVersionsOutput {
        return list_document_versions.execute(self, input, options);
    }

    /// Returns all Systems Manager (SSM) documents in the current Amazon Web
    /// Services account and Amazon Web Services Region. You can
    /// limit the results of this request by using a filter.
    pub fn listDocuments(self: *Self, input: list_documents.ListDocumentsInput, options: list_documents.Options) !list_documents.ListDocumentsOutput {
        return list_documents.execute(self, input, options);
    }

    /// A list of inventory items returned by the request.
    pub fn listInventoryEntries(self: *Self, input: list_inventory_entries.ListInventoryEntriesInput, options: list_inventory_entries.Options) !list_inventory_entries.ListInventoryEntriesOutput {
        return list_inventory_entries.execute(self, input, options);
    }

    /// Takes in filters and returns a list of managed nodes matching the filter
    /// criteria.
    pub fn listNodes(self: *Self, input: list_nodes.ListNodesInput, options: list_nodes.Options) !list_nodes.ListNodesOutput {
        return list_nodes.execute(self, input, options);
    }

    /// Generates a summary of managed instance/node metadata based on the filters
    /// and aggregators
    /// you specify. Results are grouped by the input aggregator you specify.
    pub fn listNodesSummary(self: *Self, input: list_nodes_summary.ListNodesSummaryInput, options: list_nodes_summary.Options) !list_nodes_summary.ListNodesSummaryOutput {
        return list_nodes_summary.execute(self, input, options);
    }

    /// Returns a list of all OpsItem events in the current Amazon Web Services
    /// Region and Amazon Web Services account. You can
    /// limit the results to events associated with specific OpsItems by specifying
    /// a filter.
    pub fn listOpsItemEvents(self: *Self, input: list_ops_item_events.ListOpsItemEventsInput, options: list_ops_item_events.Options) !list_ops_item_events.ListOpsItemEventsOutput {
        return list_ops_item_events.execute(self, input, options);
    }

    /// Lists all related-item resources associated with a Systems Manager OpsCenter
    /// OpsItem. OpsCenter is a
    /// tool in Amazon Web Services Systems Manager.
    pub fn listOpsItemRelatedItems(self: *Self, input: list_ops_item_related_items.ListOpsItemRelatedItemsInput, options: list_ops_item_related_items.Options) !list_ops_item_related_items.ListOpsItemRelatedItemsOutput {
        return list_ops_item_related_items.execute(self, input, options);
    }

    /// Amazon Web Services Systems Manager calls this API operation when displaying
    /// all Application Manager OpsMetadata objects or
    /// blobs.
    pub fn listOpsMetadata(self: *Self, input: list_ops_metadata.ListOpsMetadataInput, options: list_ops_metadata.Options) !list_ops_metadata.ListOpsMetadataOutput {
        return list_ops_metadata.execute(self, input, options);
    }

    /// Returns a resource-level summary count. The summary includes information
    /// about compliant and
    /// non-compliant statuses and detailed compliance-item severity counts,
    /// according to the filter
    /// criteria you specify.
    pub fn listResourceComplianceSummaries(self: *Self, input: list_resource_compliance_summaries.ListResourceComplianceSummariesInput, options: list_resource_compliance_summaries.Options) !list_resource_compliance_summaries.ListResourceComplianceSummariesOutput {
        return list_resource_compliance_summaries.execute(self, input, options);
    }

    /// Lists your resource data sync configurations. Includes information about the
    /// last time a
    /// sync attempted to start, the last sync status, and the last time a sync
    /// successfully
    /// completed.
    ///
    /// The number of sync configurations might be too large to return using a
    /// single call to
    /// `ListResourceDataSync`. You can limit the number of sync configurations
    /// returned by
    /// using the `MaxResults` parameter. To determine whether there are more sync
    /// configurations to list, check the value of `NextToken` in the output. If
    /// there are
    /// more sync configurations to list, you can request them by specifying the
    /// `NextToken`
    /// returned in the call to the parameter of a subsequent call.
    pub fn listResourceDataSync(self: *Self, input: list_resource_data_sync.ListResourceDataSyncInput, options: list_resource_data_sync.Options) !list_resource_data_sync.ListResourceDataSyncOutput {
        return list_resource_data_sync.execute(self, input, options);
    }

    /// Returns a list of the tags assigned to the specified resource.
    ///
    /// For information about the ID format for each supported resource type, see
    /// AddTagsToResource.
    pub fn listTagsForResource(self: *Self, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, input, options);
    }

    /// Shares a Amazon Web Services Systems Manager document (SSM document)publicly
    /// or privately. If you share a document
    /// privately, you must specify the Amazon Web Services user IDs for those
    /// people who can use the document. If
    /// you share a document publicly, you must specify *All* as the account
    /// ID.
    pub fn modifyDocumentPermission(self: *Self, input: modify_document_permission.ModifyDocumentPermissionInput, options: modify_document_permission.Options) !modify_document_permission.ModifyDocumentPermissionOutput {
        return modify_document_permission.execute(self, input, options);
    }

    /// Registers a compliance type and other compliance details on a designated
    /// resource. This
    /// operation lets you register custom compliance details with a resource. This
    /// call overwrites
    /// existing compliance information on the resource, so you must provide a full
    /// list of compliance
    /// items each time that you send the request.
    ///
    /// ComplianceType can be one of the following:
    ///
    /// * ExecutionId: The execution ID when the patch, association, or custom
    ///   compliance item was
    /// applied.
    ///
    /// * ExecutionType: Specify patch, association, or Custom:`string`.
    ///
    /// * ExecutionTime. The time the patch, association, or custom compliance item
    ///   was applied to
    /// the managed node.
    ///
    /// For State Manager associations, this represents the time when compliance
    /// status was
    /// captured by the Systems Manager service during its internal compliance
    /// aggregation workflow, not
    /// necessarily when the association was executed on the managed node. State
    /// Manager updates
    /// compliance information for all associations on an instance whenever any
    /// association executes,
    /// which may result in multiple associations showing the same execution time.
    ///
    /// * Id: The patch, association, or custom compliance ID.
    ///
    /// * Title: A title.
    ///
    /// * Status: The status of the compliance item. For example, `approved` for
    ///   patches,
    /// or `Failed` for associations.
    ///
    /// * Severity: A patch severity. For example, `Critical`.
    ///
    /// * DocumentName: An SSM document name. For example, `AWS-RunPatchBaseline`.
    ///
    /// * DocumentVersion: An SSM document version number. For example, 4.
    ///
    /// * Classification: A patch classification. For example, `security updates`.
    ///
    /// * PatchBaselineId: A patch baseline ID.
    ///
    /// * PatchSeverity: A patch severity. For example, `Critical`.
    ///
    /// * PatchState: A patch state. For example, `InstancesWithFailedPatches`.
    ///
    /// * PatchGroup: The name of a patch group.
    ///
    /// * InstalledTime: The time the association, patch, or custom compliance item
    ///   was applied to
    /// the resource. Specify the time by using the following format:
    /// `yyyy-MM-dd'T'HH:mm:ss'Z'`
    pub fn putComplianceItems(self: *Self, input: put_compliance_items.PutComplianceItemsInput, options: put_compliance_items.Options) !put_compliance_items.PutComplianceItemsOutput {
        return put_compliance_items.execute(self, input, options);
    }

    /// Bulk update custom inventory items on one or more managed nodes. The request
    /// adds an
    /// inventory item, if it doesn't already exist, or updates an inventory item,
    /// if it does
    /// exist.
    pub fn putInventory(self: *Self, input: put_inventory.PutInventoryInput, options: put_inventory.Options) !put_inventory.PutInventoryOutput {
        return put_inventory.execute(self, input, options);
    }

    /// Create or update a parameter in Parameter Store.
    pub fn putParameter(self: *Self, input: put_parameter.PutParameterInput, options: put_parameter.Options) !put_parameter.PutParameterOutput {
        return put_parameter.execute(self, input, options);
    }

    /// Creates or updates a Systems Manager resource policy. A resource policy
    /// helps you to define the
    /// IAM entity (for example, an Amazon Web Services account) that can manage
    /// your Systems Manager resources.
    /// The following resources support Systems Manager resource policies.
    ///
    /// * `OpsItemGroup` - The resource policy for `OpsItemGroup` enables
    /// Amazon Web Services accounts to view and interact with OpsCenter operational
    /// work items (OpsItems).
    ///
    /// * `Parameter` - The resource policy is used to share a parameter with other
    /// accounts using Resource Access Manager (RAM).
    ///
    /// To share a parameter, it must be in the advanced parameter tier. For
    /// information about
    /// parameter tiers, see [Managing
    /// parameter
    /// tiers](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html). For information about changing an existing standard parameter to an
    /// advanced parameter, see [Changing a standard parameter to an advanced
    /// parameter](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-advanced-parameters.html#parameter-store-advanced-parameters-enabling).
    ///
    /// To share a `SecureString` parameter, it must be encrypted with a customer
    /// managed key, and you must share the key separately through Key Management
    /// Service. Amazon Web Services managed keys cannot be shared. Parameters
    /// encrypted with the default Amazon Web Services managed key can be updated to
    /// use a customer managed key instead. For KMS key definitions, see [KMS
    /// concepts](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html) in the
    /// *Key Management Service Developer Guide*.
    ///
    /// While you can share a parameter using the Systems Manager
    /// `PutResourcePolicy` operation,
    /// we recommend using Resource Access Manager (RAM) instead. This is because
    /// using
    /// `PutResourcePolicy` requires the extra step of promoting the parameter to a
    /// standard RAM Resource Share using the RAM
    /// [PromoteResourceShareCreatedFromPolicy](https://docs.aws.amazon.com/ram/latest/APIReference/API_PromoteResourceShareCreatedFromPolicy.html) API operation. Otherwise, the parameter won't
    /// be returned by the Systems Manager
    /// [DescribeParameters](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_DescribeParameters.html) API operation using the `--shared` option.
    ///
    /// For more information, see [Sharing a
    /// parameter](https://docs.aws.amazon.com/systems-manager/latest/userguide/parameter-store-shared-parameters.html#share) in the *Amazon Web Services Systems Manager User Guide*
    pub fn putResourcePolicy(self: *Self, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, input, options);
    }

    /// Defines the default patch baseline for the relevant operating system.
    ///
    /// To reset the Amazon Web Services-predefined patch baseline as the default,
    /// specify the full patch baseline
    /// Amazon Resource Name (ARN) as the baseline ID value. For example, for
    /// CentOS, specify
    /// `arn:aws:ssm:us-east-2:733109147000:patchbaseline/pb-0574b43a65ea646ed`
    /// instead of
    /// `pb-0574b43a65ea646ed`.
    pub fn registerDefaultPatchBaseline(self: *Self, input: register_default_patch_baseline.RegisterDefaultPatchBaselineInput, options: register_default_patch_baseline.Options) !register_default_patch_baseline.RegisterDefaultPatchBaselineOutput {
        return register_default_patch_baseline.execute(self, input, options);
    }

    /// Registers a patch baseline for a patch group.
    pub fn registerPatchBaselineForPatchGroup(self: *Self, input: register_patch_baseline_for_patch_group.RegisterPatchBaselineForPatchGroupInput, options: register_patch_baseline_for_patch_group.Options) !register_patch_baseline_for_patch_group.RegisterPatchBaselineForPatchGroupOutput {
        return register_patch_baseline_for_patch_group.execute(self, input, options);
    }

    /// Registers a target with a maintenance window.
    pub fn registerTargetWithMaintenanceWindow(self: *Self, input: register_target_with_maintenance_window.RegisterTargetWithMaintenanceWindowInput, options: register_target_with_maintenance_window.Options) !register_target_with_maintenance_window.RegisterTargetWithMaintenanceWindowOutput {
        return register_target_with_maintenance_window.execute(self, input, options);
    }

    /// Adds a new task to a maintenance window.
    pub fn registerTaskWithMaintenanceWindow(self: *Self, input: register_task_with_maintenance_window.RegisterTaskWithMaintenanceWindowInput, options: register_task_with_maintenance_window.Options) !register_task_with_maintenance_window.RegisterTaskWithMaintenanceWindowOutput {
        return register_task_with_maintenance_window.execute(self, input, options);
    }

    /// Removes tag keys from the specified resource.
    pub fn removeTagsFromResource(self: *Self, input: remove_tags_from_resource.RemoveTagsFromResourceInput, options: remove_tags_from_resource.Options) !remove_tags_from_resource.RemoveTagsFromResourceOutput {
        return remove_tags_from_resource.execute(self, input, options);
    }

    /// `ServiceSetting` is an account-level setting for an Amazon Web Services
    /// service. This setting
    /// defines how a user interacts with or uses a service or a feature of a
    /// service. For example, if an
    /// Amazon Web Services service charges money to the account based on feature or
    /// service usage, then the Amazon Web Services
    /// service team might create a default setting of "false". This means the user
    /// can't use this
    /// feature unless they change the setting to "true" and intentionally opt in
    /// for a paid
    /// feature.
    ///
    /// Services map a `SettingId` object to a setting value. Amazon Web Services
    /// services teams define
    /// the default value for a `SettingId`. You can't create a new `SettingId`,
    /// but you can overwrite the default value if you have the
    /// `ssm:UpdateServiceSetting`
    /// permission for the setting. Use the GetServiceSetting API operation to view
    /// the
    /// current value. Use the UpdateServiceSetting API operation to change the
    /// default
    /// setting.
    ///
    /// Reset the service setting for the account to the default value as
    /// provisioned by the Amazon Web Services
    /// service team.
    pub fn resetServiceSetting(self: *Self, input: reset_service_setting.ResetServiceSettingInput, options: reset_service_setting.Options) !reset_service_setting.ResetServiceSettingOutput {
        return reset_service_setting.execute(self, input, options);
    }

    /// Reconnects a session to a managed node after it has been disconnected.
    /// Connections can be
    /// resumed for disconnected sessions, but not terminated sessions.
    ///
    /// This command is primarily for use by client machines to automatically
    /// reconnect during
    /// intermittent network issues. It isn't intended for any other use.
    pub fn resumeSession(self: *Self, input: resume_session.ResumeSessionInput, options: resume_session.Options) !resume_session.ResumeSessionOutput {
        return resume_session.execute(self, input, options);
    }

    /// Sends a signal to an Automation execution to change the current behavior or
    /// status of the
    /// execution.
    pub fn sendAutomationSignal(self: *Self, input: send_automation_signal.SendAutomationSignalInput, options: send_automation_signal.Options) !send_automation_signal.SendAutomationSignalOutput {
        return send_automation_signal.execute(self, input, options);
    }

    /// Runs commands on one or more managed nodes.
    pub fn sendCommand(self: *Self, input: send_command.SendCommandInput, options: send_command.Options) !send_command.SendCommandOutput {
        return send_command.execute(self, input, options);
    }

    /// Starts the workflow for just-in-time node access sessions.
    pub fn startAccessRequest(self: *Self, input: start_access_request.StartAccessRequestInput, options: start_access_request.Options) !start_access_request.StartAccessRequestOutput {
        return start_access_request.execute(self, input, options);
    }

    /// Runs an association immediately and only one time. This operation can be
    /// helpful when
    /// troubleshooting associations.
    pub fn startAssociationsOnce(self: *Self, input: start_associations_once.StartAssociationsOnceInput, options: start_associations_once.Options) !start_associations_once.StartAssociationsOnceOutput {
        return start_associations_once.execute(self, input, options);
    }

    /// Initiates execution of an Automation runbook.
    pub fn startAutomationExecution(self: *Self, input: start_automation_execution.StartAutomationExecutionInput, options: start_automation_execution.Options) !start_automation_execution.StartAutomationExecutionOutput {
        return start_automation_execution.execute(self, input, options);
    }

    /// Amazon Web Services Systems Manager Change Manager will no longer be open to
    /// new
    /// customers starting November 7, 2025. If you would like to use Change
    /// Manager, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [Amazon Web Services Systems Manager Change Manager availability
    /// change](https://docs.aws.amazon.com/systems-manager/latest/userguide/change-manager-availability-change.html).
    ///
    /// Creates a change request for Change Manager. The Automation runbooks
    /// specified in the
    /// change request run only after all required approvals for the change request
    /// have been
    /// received.
    pub fn startChangeRequestExecution(self: *Self, input: start_change_request_execution.StartChangeRequestExecutionInput, options: start_change_request_execution.Options) !start_change_request_execution.StartChangeRequestExecutionOutput {
        return start_change_request_execution.execute(self, input, options);
    }

    /// Initiates the process of creating a preview showing the effects that running
    /// a specified
    /// Automation runbook would have on the targeted resources.
    pub fn startExecutionPreview(self: *Self, input: start_execution_preview.StartExecutionPreviewInput, options: start_execution_preview.Options) !start_execution_preview.StartExecutionPreviewOutput {
        return start_execution_preview.execute(self, input, options);
    }

    /// Initiates a connection to a target (for example, a managed node) for a
    /// Session Manager session.
    /// Returns a URL and token that can be used to open a WebSocket connection for
    /// sending input and
    /// receiving outputs.
    ///
    /// Amazon Web Services CLI usage: `start-session` is an interactive command
    /// that requires the Session Manager
    /// plugin to be installed on the client machine making the call. For
    /// information, see [Install
    /// the Session Manager plugin for the Amazon Web Services
    /// CLI](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-working-with-install-plugin.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Amazon Web Services Tools for PowerShell usage: Start-SSMSession isn't
    /// currently supported by Amazon Web Services Tools
    /// for PowerShell on Windows local machines.
    pub fn startSession(self: *Self, input: start_session.StartSessionInput, options: start_session.Options) !start_session.StartSessionOutput {
        return start_session.execute(self, input, options);
    }

    /// Stop an Automation that is currently running.
    pub fn stopAutomationExecution(self: *Self, input: stop_automation_execution.StopAutomationExecutionInput, options: stop_automation_execution.Options) !stop_automation_execution.StopAutomationExecutionOutput {
        return stop_automation_execution.execute(self, input, options);
    }

    /// Permanently ends a session and closes the data connection between the
    /// Session Manager client and
    /// SSM Agent on the managed node. A terminated session can't be resumed.
    pub fn terminateSession(self: *Self, input: terminate_session.TerminateSessionInput, options: terminate_session.Options) !terminate_session.TerminateSessionOutput {
        return terminate_session.execute(self, input, options);
    }

    /// Remove a label or labels from a parameter.
    ///
    /// Parameter names can't contain spaces. The service removes any spaces
    /// specified for the
    /// beginning or end of a parameter name. If the specified name for a parameter
    /// contains spaces
    /// between characters, the request fails with a `ValidationException` error.
    pub fn unlabelParameterVersion(self: *Self, input: unlabel_parameter_version.UnlabelParameterVersionInput, options: unlabel_parameter_version.Options) !unlabel_parameter_version.UnlabelParameterVersionOutput {
        return unlabel_parameter_version.execute(self, input, options);
    }

    /// Updates an association. You can update the association name and version, the
    /// document
    /// version, schedule, parameters, and Amazon Simple Storage Service (Amazon S3)
    /// output. When you
    /// call `UpdateAssociation`, the system removes all optional parameters from
    /// the request
    /// and overwrites the association with null values for those parameters. This
    /// is by design. You must
    /// specify all optional parameters in the call, even if you are not changing
    /// the parameters. This
    /// includes the `Name` parameter. Before calling this API action, we recommend
    /// that you
    /// call the DescribeAssociation API operation and make a note of all optional
    /// parameters required for your `UpdateAssociation` call.
    ///
    /// In order to call this API operation, a user, group, or role must be granted
    /// permission to
    /// call the DescribeAssociation API operation. If you don't have permission to
    /// call `DescribeAssociation`, then you receive the following error: `An error
    /// occurred (AccessDeniedException) when calling the UpdateAssociation
    /// operation: User:
    /// isn't authorized to perform: ssm:DescribeAssociation on resource:
    /// `
    ///
    /// When you update an association, the association immediately runs against the
    /// specified
    /// targets. You can add the `ApplyOnlyAtCronInterval` parameter to run the
    /// association
    /// during the next schedule run.
    pub fn updateAssociation(self: *Self, input: update_association.UpdateAssociationInput, options: update_association.Options) !update_association.UpdateAssociationOutput {
        return update_association.execute(self, input, options);
    }

    /// Updates the status of the Amazon Web Services Systems Manager document (SSM
    /// document) associated with the specified
    /// managed node.
    ///
    /// `UpdateAssociationStatus` is primarily used by the Amazon Web Services
    /// Systems Manager Agent (SSM Agent) to
    /// report status updates about your associations and is only used for
    /// associations created with the
    /// `InstanceId` legacy parameter.
    pub fn updateAssociationStatus(self: *Self, input: update_association_status.UpdateAssociationStatusInput, options: update_association_status.Options) !update_association_status.UpdateAssociationStatusOutput {
        return update_association_status.execute(self, input, options);
    }

    /// Updates one or more values for an SSM document.
    pub fn updateDocument(self: *Self, input: update_document.UpdateDocumentInput, options: update_document.Options) !update_document.UpdateDocumentOutput {
        return update_document.execute(self, input, options);
    }

    /// Set the default version of a document.
    ///
    /// If you change a document version for a State Manager association, Systems
    /// Manager immediately runs
    /// the association unless you previously specifed the
    /// `apply-only-at-cron-interval`
    /// parameter.
    pub fn updateDocumentDefaultVersion(self: *Self, input: update_document_default_version.UpdateDocumentDefaultVersionInput, options: update_document_default_version.Options) !update_document_default_version.UpdateDocumentDefaultVersionOutput {
        return update_document_default_version.execute(self, input, options);
    }

    /// Amazon Web Services Systems Manager Change Manager will no longer be open to
    /// new
    /// customers starting November 7, 2025. If you would like to use Change
    /// Manager, sign up prior to that date. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [Amazon Web Services Systems Manager Change Manager availability
    /// change](https://docs.aws.amazon.com/systems-manager/latest/userguide/change-manager-availability-change.html).
    ///
    /// Updates information related to approval reviews for a specific version of a
    /// change template
    /// in Change Manager.
    pub fn updateDocumentMetadata(self: *Self, input: update_document_metadata.UpdateDocumentMetadataInput, options: update_document_metadata.Options) !update_document_metadata.UpdateDocumentMetadataOutput {
        return update_document_metadata.execute(self, input, options);
    }

    /// Updates an existing maintenance window. Only specified parameters are
    /// modified.
    ///
    /// The value you specify for `Duration` determines the specific end time for
    /// the
    /// maintenance window based on the time it begins. No maintenance window tasks
    /// are permitted to
    /// start after the resulting endtime minus the number of hours you specify for
    /// `Cutoff`.
    /// For example, if the maintenance window starts at 3 PM, the duration is three
    /// hours, and the
    /// value you specify for `Cutoff` is one hour, no maintenance window tasks can
    /// start
    /// after 5 PM.
    pub fn updateMaintenanceWindow(self: *Self, input: update_maintenance_window.UpdateMaintenanceWindowInput, options: update_maintenance_window.Options) !update_maintenance_window.UpdateMaintenanceWindowOutput {
        return update_maintenance_window.execute(self, input, options);
    }

    /// Modifies the target of an existing maintenance window. You
    /// can change the following:
    ///
    /// * Name
    ///
    /// * Description
    ///
    /// * Owner
    ///
    /// * IDs for an ID target
    ///
    /// * Tags for a Tag target
    ///
    /// * From any supported tag type to another. The three supported tag types are
    ///   ID target, Tag
    /// target, and resource group. For more information, see Target.
    ///
    /// If a parameter is null, then the corresponding field isn't modified.
    pub fn updateMaintenanceWindowTarget(self: *Self, input: update_maintenance_window_target.UpdateMaintenanceWindowTargetInput, options: update_maintenance_window_target.Options) !update_maintenance_window_target.UpdateMaintenanceWindowTargetOutput {
        return update_maintenance_window_target.execute(self, input, options);
    }

    /// Modifies a task assigned to a maintenance window. You can't change the task
    /// type, but you
    /// can change the following values:
    ///
    /// * `TaskARN`. For example, you can change a `RUN_COMMAND` task from
    /// `AWS-RunPowerShellScript` to `AWS-RunShellScript`.
    ///
    /// * `ServiceRoleArn`
    ///
    /// * `TaskInvocationParameters`
    ///
    /// * `Priority`
    ///
    /// * `MaxConcurrency`
    ///
    /// * `MaxErrors`
    ///
    /// One or more targets must be specified for maintenance window Run
    /// Command-type tasks.
    /// Depending on the task, targets are optional for other maintenance window
    /// task types (Automation,
    /// Lambda, and Step Functions). For more information about running tasks
    /// that don't specify targets, see [Registering
    /// maintenance window tasks without
    /// targets](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// If the value for a parameter in `UpdateMaintenanceWindowTask` is null, then
    /// the
    /// corresponding field isn't modified. If you set `Replace` to true, then all
    /// fields
    /// required by the RegisterTaskWithMaintenanceWindow operation are required for
    /// this request. Optional fields that aren't specified are set to null.
    ///
    /// When you update a maintenance window task that has options specified in
    /// `TaskInvocationParameters`, you must provide again all the
    /// `TaskInvocationParameters` values that you want to retain. The values you
    /// don't
    /// specify again are removed. For example, suppose that when you registered a
    /// Run Command task, you
    /// specified `TaskInvocationParameters` values for `Comment`,
    /// `NotificationConfig`, and `OutputS3BucketName`. If you update the
    /// maintenance window task and specify only a different `OutputS3BucketName`
    /// value, the
    /// values for `Comment` and `NotificationConfig` are removed.
    pub fn updateMaintenanceWindowTask(self: *Self, input: update_maintenance_window_task.UpdateMaintenanceWindowTaskInput, options: update_maintenance_window_task.Options) !update_maintenance_window_task.UpdateMaintenanceWindowTaskOutput {
        return update_maintenance_window_task.execute(self, input, options);
    }

    /// Changes the Identity and Access Management (IAM) role that is assigned to
    /// the
    /// on-premises server, edge device, or virtual machines (VM). IAM roles are
    /// first
    /// assigned to these hybrid nodes during the activation process. For more
    /// information, see CreateActivation.
    pub fn updateManagedInstanceRole(self: *Self, input: update_managed_instance_role.UpdateManagedInstanceRoleInput, options: update_managed_instance_role.Options) !update_managed_instance_role.UpdateManagedInstanceRoleOutput {
        return update_managed_instance_role.execute(self, input, options);
    }

    /// Edit or change an OpsItem. You must have permission in Identity and Access
    /// Management (IAM) to update an OpsItem. For more information, see [Set up
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setup.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    ///
    /// Operations engineers and IT professionals use Amazon Web Services Systems
    /// Manager OpsCenter to view, investigate, and
    /// remediate operational issues impacting the performance and health of their
    /// Amazon Web Services resources. For
    /// more information, see [Amazon Web Services Systems Manager
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    pub fn updateOpsItem(self: *Self, input: update_ops_item.UpdateOpsItemInput, options: update_ops_item.Options) !update_ops_item.UpdateOpsItemOutput {
        return update_ops_item.execute(self, input, options);
    }

    /// Amazon Web Services Systems Manager calls this API operation when you edit
    /// OpsMetadata in Application Manager.
    pub fn updateOpsMetadata(self: *Self, input: update_ops_metadata.UpdateOpsMetadataInput, options: update_ops_metadata.Options) !update_ops_metadata.UpdateOpsMetadataOutput {
        return update_ops_metadata.execute(self, input, options);
    }

    /// Modifies an existing patch baseline. Fields not specified in the request are
    /// left
    /// unchanged.
    ///
    /// For information about valid key-value pairs in `PatchFilters` for each
    /// supported
    /// operating system type, see PatchFilter.
    pub fn updatePatchBaseline(self: *Self, input: update_patch_baseline.UpdatePatchBaselineInput, options: update_patch_baseline.Options) !update_patch_baseline.UpdatePatchBaselineOutput {
        return update_patch_baseline.execute(self, input, options);
    }

    /// Update a resource data sync. After you create a resource data sync for a
    /// Region, you can't
    /// change the account options for that sync. For example, if you create a sync
    /// in the us-east-2
    /// (Ohio) Region and you choose the `Include only the current account` option,
    /// you can't
    /// edit that sync later and choose the `Include all accounts from my
    /// Organizations
    /// configuration` option. Instead, you must delete the first resource data
    /// sync, and create a
    /// new one.
    ///
    /// This API operation only supports a resource data sync that was created with
    /// a
    /// SyncFromSource `SyncType`.
    pub fn updateResourceDataSync(self: *Self, input: update_resource_data_sync.UpdateResourceDataSyncInput, options: update_resource_data_sync.Options) !update_resource_data_sync.UpdateResourceDataSyncOutput {
        return update_resource_data_sync.execute(self, input, options);
    }

    /// `ServiceSetting` is an account-level setting for an Amazon Web Services
    /// service. This setting
    /// defines how a user interacts with or uses a service or a feature of a
    /// service. For example, if an
    /// Amazon Web Services service charges money to the account based on feature or
    /// service usage, then the Amazon Web Services
    /// service team might create a default setting of "false". This means the user
    /// can't use this
    /// feature unless they change the setting to "true" and intentionally opt in
    /// for a paid
    /// feature.
    ///
    /// Services map a `SettingId` object to a setting value. Amazon Web Services
    /// services teams define
    /// the default value for a `SettingId`. You can't create a new `SettingId`,
    /// but you can overwrite the default value if you have the
    /// `ssm:UpdateServiceSetting`
    /// permission for the setting. Use the GetServiceSetting API operation to view
    /// the
    /// current value. Or, use the ResetServiceSetting to change the value back to
    /// the
    /// original value defined by the Amazon Web Services service team.
    ///
    /// Update the service setting for the account.
    pub fn updateServiceSetting(self: *Self, input: update_service_setting.UpdateServiceSettingInput, options: update_service_setting.Options) !update_service_setting.UpdateServiceSettingOutput {
        return update_service_setting.execute(self, input, options);
    }

    pub fn describeActivationsPaginator(self: *Self, params: describe_activations.DescribeActivationsInput) paginator.DescribeActivationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAssociationExecutionTargetsPaginator(self: *Self, params: describe_association_execution_targets.DescribeAssociationExecutionTargetsInput) paginator.DescribeAssociationExecutionTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAssociationExecutionsPaginator(self: *Self, params: describe_association_executions.DescribeAssociationExecutionsInput) paginator.DescribeAssociationExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAutomationExecutionsPaginator(self: *Self, params: describe_automation_executions.DescribeAutomationExecutionsInput) paginator.DescribeAutomationExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAutomationStepExecutionsPaginator(self: *Self, params: describe_automation_step_executions.DescribeAutomationStepExecutionsInput) paginator.DescribeAutomationStepExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAvailablePatchesPaginator(self: *Self, params: describe_available_patches.DescribeAvailablePatchesInput) paginator.DescribeAvailablePatchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEffectiveInstanceAssociationsPaginator(self: *Self, params: describe_effective_instance_associations.DescribeEffectiveInstanceAssociationsInput) paginator.DescribeEffectiveInstanceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEffectivePatchesForPatchBaselinePaginator(self: *Self, params: describe_effective_patches_for_patch_baseline.DescribeEffectivePatchesForPatchBaselineInput) paginator.DescribeEffectivePatchesForPatchBaselinePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceAssociationsStatusPaginator(self: *Self, params: describe_instance_associations_status.DescribeInstanceAssociationsStatusInput) paginator.DescribeInstanceAssociationsStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceInformationPaginator(self: *Self, params: describe_instance_information.DescribeInstanceInformationInput) paginator.DescribeInstanceInformationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstancePatchStatesPaginator(self: *Self, params: describe_instance_patch_states.DescribeInstancePatchStatesInput) paginator.DescribeInstancePatchStatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstancePatchStatesForPatchGroupPaginator(self: *Self, params: describe_instance_patch_states_for_patch_group.DescribeInstancePatchStatesForPatchGroupInput) paginator.DescribeInstancePatchStatesForPatchGroupPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstancePatchesPaginator(self: *Self, params: describe_instance_patches.DescribeInstancePatchesInput) paginator.DescribeInstancePatchesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstancePropertiesPaginator(self: *Self, params: describe_instance_properties.DescribeInstancePropertiesInput) paginator.DescribeInstancePropertiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInventoryDeletionsPaginator(self: *Self, params: describe_inventory_deletions.DescribeInventoryDeletionsInput) paginator.DescribeInventoryDeletionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowExecutionTaskInvocationsPaginator(self: *Self, params: describe_maintenance_window_execution_task_invocations.DescribeMaintenanceWindowExecutionTaskInvocationsInput) paginator.DescribeMaintenanceWindowExecutionTaskInvocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowExecutionTasksPaginator(self: *Self, params: describe_maintenance_window_execution_tasks.DescribeMaintenanceWindowExecutionTasksInput) paginator.DescribeMaintenanceWindowExecutionTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowExecutionsPaginator(self: *Self, params: describe_maintenance_window_executions.DescribeMaintenanceWindowExecutionsInput) paginator.DescribeMaintenanceWindowExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowSchedulePaginator(self: *Self, params: describe_maintenance_window_schedule.DescribeMaintenanceWindowScheduleInput) paginator.DescribeMaintenanceWindowSchedulePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowTargetsPaginator(self: *Self, params: describe_maintenance_window_targets.DescribeMaintenanceWindowTargetsInput) paginator.DescribeMaintenanceWindowTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowTasksPaginator(self: *Self, params: describe_maintenance_window_tasks.DescribeMaintenanceWindowTasksInput) paginator.DescribeMaintenanceWindowTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowsPaginator(self: *Self, params: describe_maintenance_windows.DescribeMaintenanceWindowsInput) paginator.DescribeMaintenanceWindowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMaintenanceWindowsForTargetPaginator(self: *Self, params: describe_maintenance_windows_for_target.DescribeMaintenanceWindowsForTargetInput) paginator.DescribeMaintenanceWindowsForTargetPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeOpsItemsPaginator(self: *Self, params: describe_ops_items.DescribeOpsItemsInput) paginator.DescribeOpsItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeParametersPaginator(self: *Self, params: describe_parameters.DescribeParametersInput) paginator.DescribeParametersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePatchBaselinesPaginator(self: *Self, params: describe_patch_baselines.DescribePatchBaselinesInput) paginator.DescribePatchBaselinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePatchGroupsPaginator(self: *Self, params: describe_patch_groups.DescribePatchGroupsInput) paginator.DescribePatchGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePatchPropertiesPaginator(self: *Self, params: describe_patch_properties.DescribePatchPropertiesInput) paginator.DescribePatchPropertiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSessionsPaginator(self: *Self, params: describe_sessions.DescribeSessionsInput) paginator.DescribeSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getInventoryPaginator(self: *Self, params: get_inventory.GetInventoryInput) paginator.GetInventoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getInventorySchemaPaginator(self: *Self, params: get_inventory_schema.GetInventorySchemaInput) paginator.GetInventorySchemaPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getOpsSummaryPaginator(self: *Self, params: get_ops_summary.GetOpsSummaryInput) paginator.GetOpsSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getParameterHistoryPaginator(self: *Self, params: get_parameter_history.GetParameterHistoryInput) paginator.GetParameterHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getParametersByPathPaginator(self: *Self, params: get_parameters_by_path.GetParametersByPathInput) paginator.GetParametersByPathPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getResourcePoliciesPaginator(self: *Self, params: get_resource_policies.GetResourcePoliciesInput) paginator.GetResourcePoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociationVersionsPaginator(self: *Self, params: list_association_versions.ListAssociationVersionsInput) paginator.ListAssociationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociationsPaginator(self: *Self, params: list_associations.ListAssociationsInput) paginator.ListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommandInvocationsPaginator(self: *Self, params: list_command_invocations.ListCommandInvocationsInput) paginator.ListCommandInvocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCommandsPaginator(self: *Self, params: list_commands.ListCommandsInput) paginator.ListCommandsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComplianceItemsPaginator(self: *Self, params: list_compliance_items.ListComplianceItemsInput) paginator.ListComplianceItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listComplianceSummariesPaginator(self: *Self, params: list_compliance_summaries.ListComplianceSummariesInput) paginator.ListComplianceSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDocumentVersionsPaginator(self: *Self, params: list_document_versions.ListDocumentVersionsInput) paginator.ListDocumentVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDocumentsPaginator(self: *Self, params: list_documents.ListDocumentsInput) paginator.ListDocumentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesPaginator(self: *Self, params: list_nodes.ListNodesInput) paginator.ListNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesSummaryPaginator(self: *Self, params: list_nodes_summary.ListNodesSummaryInput) paginator.ListNodesSummaryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOpsItemEventsPaginator(self: *Self, params: list_ops_item_events.ListOpsItemEventsInput) paginator.ListOpsItemEventsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOpsItemRelatedItemsPaginator(self: *Self, params: list_ops_item_related_items.ListOpsItemRelatedItemsInput) paginator.ListOpsItemRelatedItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOpsMetadataPaginator(self: *Self, params: list_ops_metadata.ListOpsMetadataInput) paginator.ListOpsMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceComplianceSummariesPaginator(self: *Self, params: list_resource_compliance_summaries.ListResourceComplianceSummariesInput) paginator.ListResourceComplianceSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourceDataSyncPaginator(self: *Self, params: list_resource_data_sync.ListResourceDataSyncInput) paginator.ListResourceDataSyncPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilCommandExecuted(self: *Self, params: get_command_invocation.GetCommandInvocationInput) aws.waiter.WaiterError!void {
        var w = waiters.CommandExecutedWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
