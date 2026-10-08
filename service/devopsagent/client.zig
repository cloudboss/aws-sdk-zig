const aws = @import("aws");
const std = @import("std");

const associate_service = @import("associate_service.zig");
const create_agent_space = @import("create_agent_space.zig");
const create_asset = @import("create_asset.zig");
const create_asset_file = @import("create_asset_file.zig");
const create_backlog_task = @import("create_backlog_task.zig");
const create_chat = @import("create_chat.zig");
const create_private_connection = @import("create_private_connection.zig");
const create_trigger = @import("create_trigger.zig");
const delete_agent_space = @import("delete_agent_space.zig");
const delete_asset = @import("delete_asset.zig");
const delete_asset_file = @import("delete_asset_file.zig");
const delete_private_connection = @import("delete_private_connection.zig");
const delete_trigger = @import("delete_trigger.zig");
const deregister_service = @import("deregister_service.zig");
const describe_private_connection = @import("describe_private_connection.zig");
const disable_operator_app = @import("disable_operator_app.zig");
const disassociate_service = @import("disassociate_service.zig");
const enable_operator_app = @import("enable_operator_app.zig");
const get_account_usage = @import("get_account_usage.zig");
const get_agent_space = @import("get_agent_space.zig");
const get_asset = @import("get_asset.zig");
const get_asset_content = @import("get_asset_content.zig");
const get_asset_file = @import("get_asset_file.zig");
const get_association = @import("get_association.zig");
const get_backlog_task = @import("get_backlog_task.zig");
const get_operator_app = @import("get_operator_app.zig");
const get_recommendation = @import("get_recommendation.zig");
const get_service = @import("get_service.zig");
const get_trigger = @import("get_trigger.zig");
const list_agent_spaces = @import("list_agent_spaces.zig");
const list_asset_files = @import("list_asset_files.zig");
const list_asset_types = @import("list_asset_types.zig");
const list_asset_versions = @import("list_asset_versions.zig");
const list_assets = @import("list_assets.zig");
const list_associations = @import("list_associations.zig");
const list_backlog_tasks = @import("list_backlog_tasks.zig");
const list_chats = @import("list_chats.zig");
const list_executions = @import("list_executions.zig");
const list_goals = @import("list_goals.zig");
const list_journal_records = @import("list_journal_records.zig");
const list_pending_messages = @import("list_pending_messages.zig");
const list_private_connections = @import("list_private_connections.zig");
const list_recommendations = @import("list_recommendations.zig");
const list_services = @import("list_services.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_triggers = @import("list_triggers.zig");
const list_webhooks = @import("list_webhooks.zig");
const register_service = @import("register_service.zig");
const send_message = @import("send_message.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent_space = @import("update_agent_space.zig");
const update_approval_action = @import("update_approval_action.zig");
const update_asset = @import("update_asset.zig");
const update_asset_file = @import("update_asset_file.zig");
const update_association = @import("update_association.zig");
const update_backlog_task = @import("update_backlog_task.zig");
const update_goal = @import("update_goal.zig");
const update_operator_app_idp_config = @import("update_operator_app_idp_config.zig");
const update_private_connection_certificate = @import("update_private_connection_certificate.zig");
const update_recommendation = @import("update_recommendation.zig");
const update_trigger = @import("update_trigger.zig");
const validate_aws_associations = @import("validate_aws_associations.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "DevOps Agent";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Adds a specific service association to an AgentSpace. It overwrites the
    /// existing association of the same service. Returns 201 Created on success.
    pub fn associateService(self: *Self, allocator: std.mem.Allocator, input: associate_service.AssociateServiceInput, options: CallOptions) !associate_service.AssociateServiceOutput {
        return associate_service.execute(self, allocator, input, options);
    }

    /// Creates a new AgentSpace with the specified name and description. Duplicate
    /// space names are allowed.
    pub fn createAgentSpace(self: *Self, allocator: std.mem.Allocator, input: create_agent_space.CreateAgentSpaceInput, options: CallOptions) !create_agent_space.CreateAgentSpaceOutput {
        return create_agent_space.execute(self, allocator, input, options);
    }

    /// Creates a new asset in the specified agent space
    pub fn createAsset(self: *Self, allocator: std.mem.Allocator, input: create_asset.CreateAssetInput, options: CallOptions) !create_asset.CreateAssetOutput {
        return create_asset.execute(self, allocator, input, options);
    }

    /// Creates a file in an asset
    pub fn createAssetFile(self: *Self, allocator: std.mem.Allocator, input: create_asset_file.CreateAssetFileInput, options: CallOptions) !create_asset_file.CreateAssetFileOutput {
        return create_asset_file.execute(self, allocator, input, options);
    }

    /// Creates a new backlog task in the specified agent space
    pub fn createBacklogTask(self: *Self, allocator: std.mem.Allocator, input: create_backlog_task.CreateBacklogTaskInput, options: CallOptions) !create_backlog_task.CreateBacklogTaskOutput {
        return create_backlog_task.execute(self, allocator, input, options);
    }

    /// Creates a new chat execution in the specified agent space
    pub fn createChat(self: *Self, allocator: std.mem.Allocator, input: create_chat.CreateChatInput, options: CallOptions) !create_chat.CreateChatOutput {
        return create_chat.execute(self, allocator, input, options);
    }

    /// Creates a Private Connection to a target resource.
    pub fn createPrivateConnection(self: *Self, allocator: std.mem.Allocator, input: create_private_connection.CreatePrivateConnectionInput, options: CallOptions) !create_private_connection.CreatePrivateConnectionOutput {
        return create_private_connection.execute(self, allocator, input, options);
    }

    /// Creates a new Trigger in the specified agent space
    pub fn createTrigger(self: *Self, allocator: std.mem.Allocator, input: create_trigger.CreateTriggerInput, options: CallOptions) !create_trigger.CreateTriggerOutput {
        return create_trigger.execute(self, allocator, input, options);
    }

    /// Deletes an AgentSpace. This operation is idempotent and returns a 204 No
    /// Content response on success.
    pub fn deleteAgentSpace(self: *Self, allocator: std.mem.Allocator, input: delete_agent_space.DeleteAgentSpaceInput, options: CallOptions) !delete_agent_space.DeleteAgentSpaceOutput {
        return delete_agent_space.execute(self, allocator, input, options);
    }

    /// Deletes an asset and all its files from the specified agent space
    pub fn deleteAsset(self: *Self, allocator: std.mem.Allocator, input: delete_asset.DeleteAssetInput, options: CallOptions) !delete_asset.DeleteAssetOutput {
        return delete_asset.execute(self, allocator, input, options);
    }

    /// Deletes a file from an asset
    pub fn deleteAssetFile(self: *Self, allocator: std.mem.Allocator, input: delete_asset_file.DeleteAssetFileInput, options: CallOptions) !delete_asset_file.DeleteAssetFileOutput {
        return delete_asset_file.execute(self, allocator, input, options);
    }

    /// Deletes a Private Connection. The deletion is asynchronous and returns
    /// DELETE_IN_PROGRESS status.
    pub fn deletePrivateConnection(self: *Self, allocator: std.mem.Allocator, input: delete_private_connection.DeletePrivateConnectionInput, options: CallOptions) !delete_private_connection.DeletePrivateConnectionOutput {
        return delete_private_connection.execute(self, allocator, input, options);
    }

    /// Deletes a Trigger from the specified agent space
    pub fn deleteTrigger(self: *Self, allocator: std.mem.Allocator, input: delete_trigger.DeleteTriggerInput, options: CallOptions) !delete_trigger.DeleteTriggerOutput {
        return delete_trigger.execute(self, allocator, input, options);
    }

    /// Deregister a service
    pub fn deregisterService(self: *Self, allocator: std.mem.Allocator, input: deregister_service.DeregisterServiceInput, options: CallOptions) !deregister_service.DeregisterServiceOutput {
        return deregister_service.execute(self, allocator, input, options);
    }

    /// Retrieves details of an existing Private Connection.
    pub fn describePrivateConnection(self: *Self, allocator: std.mem.Allocator, input: describe_private_connection.DescribePrivateConnectionInput, options: CallOptions) !describe_private_connection.DescribePrivateConnectionOutput {
        return describe_private_connection.execute(self, allocator, input, options);
    }

    /// Disable the Operator App for the specified AgentSpace
    pub fn disableOperatorApp(self: *Self, allocator: std.mem.Allocator, input: disable_operator_app.DisableOperatorAppInput, options: CallOptions) !disable_operator_app.DisableOperatorAppOutput {
        return disable_operator_app.execute(self, allocator, input, options);
    }

    /// Deletes a specific service association from an AgentSpace. This operation is
    /// idempotent and returns a 204 No Content response on success.
    pub fn disassociateService(self: *Self, allocator: std.mem.Allocator, input: disassociate_service.DisassociateServiceInput, options: CallOptions) !disassociate_service.DisassociateServiceOutput {
        return disassociate_service.execute(self, allocator, input, options);
    }

    /// Enable the Operator App to access the given AgentSpace
    pub fn enableOperatorApp(self: *Self, allocator: std.mem.Allocator, input: enable_operator_app.EnableOperatorAppInput, options: CallOptions) !enable_operator_app.EnableOperatorAppOutput {
        return enable_operator_app.execute(self, allocator, input, options);
    }

    /// Retrieves monthly account usage metrics and limits for the AWS account.
    pub fn getAccountUsage(self: *Self, allocator: std.mem.Allocator, input: get_account_usage.GetAccountUsageInput, options: CallOptions) !get_account_usage.GetAccountUsageOutput {
        return get_account_usage.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific AgentSpace.
    pub fn getAgentSpace(self: *Self, allocator: std.mem.Allocator, input: get_agent_space.GetAgentSpaceInput, options: CallOptions) !get_agent_space.GetAgentSpaceOutput {
        return get_agent_space.execute(self, allocator, input, options);
    }

    /// Gets an asset from the specified agent space
    pub fn getAsset(self: *Self, allocator: std.mem.Allocator, input: get_asset.GetAssetInput, options: CallOptions) !get_asset.GetAssetOutput {
        return get_asset.execute(self, allocator, input, options);
    }

    /// Gets an asset's content as a zip bundle
    pub fn getAssetContent(self: *Self, allocator: std.mem.Allocator, input: get_asset_content.GetAssetContentInput, options: CallOptions) !get_asset_content.GetAssetContentOutput {
        return get_asset_content.execute(self, allocator, input, options);
    }

    /// Gets a file from an asset
    pub fn getAssetFile(self: *Self, allocator: std.mem.Allocator, input: get_asset_file.GetAssetFileInput, options: CallOptions) !get_asset_file.GetAssetFileOutput {
        return get_asset_file.execute(self, allocator, input, options);
    }

    /// Retrieves given associations configured for a specific AgentSpace.
    pub fn getAssociation(self: *Self, allocator: std.mem.Allocator, input: get_association.GetAssociationInput, options: CallOptions) !get_association.GetAssociationOutput {
        return get_association.execute(self, allocator, input, options);
    }

    /// Gets a backlog task for the specified agent space and task id
    pub fn getBacklogTask(self: *Self, allocator: std.mem.Allocator, input: get_backlog_task.GetBacklogTaskInput, options: CallOptions) !get_backlog_task.GetBacklogTaskOutput {
        return get_backlog_task.execute(self, allocator, input, options);
    }

    /// Get the full auth configuration of operator including any enabled auth flow
    pub fn getOperatorApp(self: *Self, allocator: std.mem.Allocator, input: get_operator_app.GetOperatorAppInput, options: CallOptions) !get_operator_app.GetOperatorAppOutput {
        return get_operator_app.execute(self, allocator, input, options);
    }

    /// Retrieves a specific recommendation by its ID
    pub fn getRecommendation(self: *Self, allocator: std.mem.Allocator, input: get_recommendation.GetRecommendationInput, options: CallOptions) !get_recommendation.GetRecommendationOutput {
        return get_recommendation.execute(self, allocator, input, options);
    }

    /// Retrieves given service by it's unique identifier
    pub fn getService(self: *Self, allocator: std.mem.Allocator, input: get_service.GetServiceInput, options: CallOptions) !get_service.GetServiceOutput {
        return get_service.execute(self, allocator, input, options);
    }

    /// Gets a Trigger from the specified agent space
    pub fn getTrigger(self: *Self, allocator: std.mem.Allocator, input: get_trigger.GetTriggerInput, options: CallOptions) !get_trigger.GetTriggerOutput {
        return get_trigger.execute(self, allocator, input, options);
    }

    /// Lists all AgentSpaces with optional pagination.
    pub fn listAgentSpaces(self: *Self, allocator: std.mem.Allocator, input: list_agent_spaces.ListAgentSpacesInput, options: CallOptions) !list_agent_spaces.ListAgentSpacesOutput {
        return list_agent_spaces.execute(self, allocator, input, options);
    }

    /// Lists files in an asset
    pub fn listAssetFiles(self: *Self, allocator: std.mem.Allocator, input: list_asset_files.ListAssetFilesInput, options: CallOptions) !list_asset_files.ListAssetFilesOutput {
        return list_asset_files.execute(self, allocator, input, options);
    }

    /// Lists the supported asset types
    pub fn listAssetTypes(self: *Self, allocator: std.mem.Allocator, input: list_asset_types.ListAssetTypesInput, options: CallOptions) !list_asset_types.ListAssetTypesOutput {
        return list_asset_types.execute(self, allocator, input, options);
    }

    /// Lists versions of an asset in the specified agent space
    pub fn listAssetVersions(self: *Self, allocator: std.mem.Allocator, input: list_asset_versions.ListAssetVersionsInput, options: CallOptions) !list_asset_versions.ListAssetVersionsOutput {
        return list_asset_versions.execute(self, allocator, input, options);
    }

    /// Lists assets in the specified agent space
    pub fn listAssets(self: *Self, allocator: std.mem.Allocator, input: list_assets.ListAssetsInput, options: CallOptions) !list_assets.ListAssetsOutput {
        return list_assets.execute(self, allocator, input, options);
    }

    /// List all associations for given AgentSpace
    pub fn listAssociations(self: *Self, allocator: std.mem.Allocator, input: list_associations.ListAssociationsInput, options: CallOptions) !list_associations.ListAssociationsOutput {
        return list_associations.execute(self, allocator, input, options);
    }

    /// Lists backlog tasks in the specified agent space with optional filtering and
    /// sorting
    pub fn listBacklogTasks(self: *Self, allocator: std.mem.Allocator, input: list_backlog_tasks.ListBacklogTasksInput, options: CallOptions) !list_backlog_tasks.ListBacklogTasksOutput {
        return list_backlog_tasks.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the user's recent chat executions
    pub fn listChats(self: *Self, allocator: std.mem.Allocator, input: list_chats.ListChatsInput, options: CallOptions) !list_chats.ListChatsOutput {
        return list_chats.execute(self, allocator, input, options);
    }

    /// List executions
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: CallOptions) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Lists goals in the specified agent space with optional filtering
    pub fn listGoals(self: *Self, allocator: std.mem.Allocator, input: list_goals.ListGoalsInput, options: CallOptions) !list_goals.ListGoalsOutput {
        return list_goals.execute(self, allocator, input, options);
    }

    /// List journal records for a specific execution
    pub fn listJournalRecords(self: *Self, allocator: std.mem.Allocator, input: list_journal_records.ListJournalRecordsInput, options: CallOptions) !list_journal_records.ListJournalRecordsOutput {
        return list_journal_records.execute(self, allocator, input, options);
    }

    /// List pending messages for a specific execution.
    pub fn listPendingMessages(self: *Self, allocator: std.mem.Allocator, input: list_pending_messages.ListPendingMessagesInput, options: CallOptions) !list_pending_messages.ListPendingMessagesOutput {
        return list_pending_messages.execute(self, allocator, input, options);
    }

    /// Lists all Private Connections in the caller's account.
    pub fn listPrivateConnections(self: *Self, allocator: std.mem.Allocator, input: list_private_connections.ListPrivateConnectionsInput, options: CallOptions) !list_private_connections.ListPrivateConnectionsOutput {
        return list_private_connections.execute(self, allocator, input, options);
    }

    /// Lists recommendations for the specified agent space
    pub fn listRecommendations(self: *Self, allocator: std.mem.Allocator, input: list_recommendations.ListRecommendationsInput, options: CallOptions) !list_recommendations.ListRecommendationsOutput {
        return list_recommendations.execute(self, allocator, input, options);
    }

    /// List a list of registered service on the account level.
    pub fn listServices(self: *Self, allocator: std.mem.Allocator, input: list_services.ListServicesInput, options: CallOptions) !list_services.ListServicesOutput {
        return list_services.execute(self, allocator, input, options);
    }

    /// Lists tags for the specified AWS DevOps Agent resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists Triggers in the specified agent space
    pub fn listTriggers(self: *Self, allocator: std.mem.Allocator, input: list_triggers.ListTriggersInput, options: CallOptions) !list_triggers.ListTriggersOutput {
        return list_triggers.execute(self, allocator, input, options);
    }

    /// List all webhooks for given Association
    pub fn listWebhooks(self: *Self, allocator: std.mem.Allocator, input: list_webhooks.ListWebhooksInput, options: CallOptions) !list_webhooks.ListWebhooksOutput {
        return list_webhooks.execute(self, allocator, input, options);
    }

    /// This operation registers the specified service
    pub fn registerService(self: *Self, allocator: std.mem.Allocator, input: register_service.RegisterServiceInput, options: CallOptions) !register_service.RegisterServiceOutput {
        return register_service.execute(self, allocator, input, options);
    }

    /// Sends a chat message and streams the response for the specified agent space
    /// execution
    pub fn sendMessage(self: *Self, allocator: std.mem.Allocator, input: send_message.SendMessageInput, options: CallOptions) !send_message.SendMessageOutput {
        return send_message.execute(self, allocator, input, options);
    }

    /// Adds or overwrites tags for the specified AWS DevOps Agent resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified AWS DevOps Agent resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the information of an existing AgentSpace.
    pub fn updateAgentSpace(self: *Self, allocator: std.mem.Allocator, input: update_agent_space.UpdateAgentSpaceInput, options: CallOptions) !update_agent_space.UpdateAgentSpaceOutput {
        return update_agent_space.execute(self, allocator, input, options);
    }

    /// Updates an approval request with the terminal decision (APPROVED or
    /// REJECTED). A single operation handles both verbs via the action enum.
    pub fn updateApprovalAction(self: *Self, allocator: std.mem.Allocator, input: update_approval_action.UpdateApprovalActionInput, options: CallOptions) !update_approval_action.UpdateApprovalActionOutput {
        return update_approval_action.execute(self, allocator, input, options);
    }

    /// Updates an asset in the specified agent space
    pub fn updateAsset(self: *Self, allocator: std.mem.Allocator, input: update_asset.UpdateAssetInput, options: CallOptions) !update_asset.UpdateAssetOutput {
        return update_asset.execute(self, allocator, input, options);
    }

    /// Updates a file in an asset
    pub fn updateAssetFile(self: *Self, allocator: std.mem.Allocator, input: update_asset_file.UpdateAssetFileInput, options: CallOptions) !update_asset_file.UpdateAssetFileOutput {
        return update_asset_file.execute(self, allocator, input, options);
    }

    /// Partially updates the configuration of an existing service association for
    /// an AgentSpace. Present fields are fully replaced; absent fields are left
    /// unchanged. Returns 200 OK on success.
    pub fn updateAssociation(self: *Self, allocator: std.mem.Allocator, input: update_association.UpdateAssociationInput, options: CallOptions) !update_association.UpdateAssociationOutput {
        return update_association.execute(self, allocator, input, options);
    }

    /// Update an existing backlog task.
    pub fn updateBacklogTask(self: *Self, allocator: std.mem.Allocator, input: update_backlog_task.UpdateBacklogTaskInput, options: CallOptions) !update_backlog_task.UpdateBacklogTaskOutput {
        return update_backlog_task.execute(self, allocator, input, options);
    }

    /// Update an existing goal
    pub fn updateGoal(self: *Self, allocator: std.mem.Allocator, input: update_goal.UpdateGoalInput, options: CallOptions) !update_goal.UpdateGoalOutput {
        return update_goal.execute(self, allocator, input, options);
    }

    /// Update the external Identity Provider configuration for the Operator App
    pub fn updateOperatorAppIdpConfig(self: *Self, allocator: std.mem.Allocator, input: update_operator_app_idp_config.UpdateOperatorAppIdpConfigInput, options: CallOptions) !update_operator_app_idp_config.UpdateOperatorAppIdpConfigOutput {
        return update_operator_app_idp_config.execute(self, allocator, input, options);
    }

    /// Updates the certificate associated with a Private Connection.
    pub fn updatePrivateConnectionCertificate(self: *Self, allocator: std.mem.Allocator, input: update_private_connection_certificate.UpdatePrivateConnectionCertificateInput, options: CallOptions) !update_private_connection_certificate.UpdatePrivateConnectionCertificateOutput {
        return update_private_connection_certificate.execute(self, allocator, input, options);
    }

    /// Updates an existing recommendation with new content, status, or metadata
    pub fn updateRecommendation(self: *Self, allocator: std.mem.Allocator, input: update_recommendation.UpdateRecommendationInput, options: CallOptions) !update_recommendation.UpdateRecommendationOutput {
        return update_recommendation.execute(self, allocator, input, options);
    }

    /// Updates the status of an existing Trigger
    pub fn updateTrigger(self: *Self, allocator: std.mem.Allocator, input: update_trigger.UpdateTriggerInput, options: CallOptions) !update_trigger.UpdateTriggerOutput {
        return update_trigger.execute(self, allocator, input, options);
    }

    /// Validates an aws association and set status and returns a 204 No Content
    /// response on success.
    pub fn validateAwsAssociations(self: *Self, allocator: std.mem.Allocator, input: validate_aws_associations.ValidateAwsAssociationsInput, options: CallOptions) !validate_aws_associations.ValidateAwsAssociationsOutput {
        return validate_aws_associations.execute(self, allocator, input, options);
    }

    pub fn listAgentSpacesPaginator(self: *Self, params: list_agent_spaces.ListAgentSpacesInput) paginator.ListAgentSpacesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetFilesPaginator(self: *Self, params: list_asset_files.ListAssetFilesInput) paginator.ListAssetFilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetTypesPaginator(self: *Self, params: list_asset_types.ListAssetTypesInput) paginator.ListAssetTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetVersionsPaginator(self: *Self, params: list_asset_versions.ListAssetVersionsInput) paginator.ListAssetVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssetsPaginator(self: *Self, params: list_assets.ListAssetsInput) paginator.ListAssetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAssociationsPaginator(self: *Self, params: list_associations.ListAssociationsInput) paginator.ListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBacklogTasksPaginator(self: *Self, params: list_backlog_tasks.ListBacklogTasksInput) paginator.ListBacklogTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGoalsPaginator(self: *Self, params: list_goals.ListGoalsInput) paginator.ListGoalsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJournalRecordsPaginator(self: *Self, params: list_journal_records.ListJournalRecordsInput) paginator.ListJournalRecordsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listServicesPaginator(self: *Self, params: list_services.ListServicesInput) paginator.ListServicesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTriggersPaginator(self: *Self, params: list_triggers.ListTriggersInput) paginator.ListTriggersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
